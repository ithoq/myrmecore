/*
 * MyrmeCore
 *
 * A Web-based Wireless Sensor Network Management System
 *
 * @package        	MyrmeCore
 * @author        	Juan F. Duque <jfelipe@grupodyd.com>
 * @copyright    	Copyright (c) 2011, Dinamica y Desarrollo Ltda.
 * @license        	http://www.myrmecore.com/license/
 * @link        	http://www.myrmecore.com
 * @since        	Version 0.1
 * @filesource
 */

function columnWrap(val){
    return '<div style="white-space:normal !important;">'+ val +'</div>';
}

Ext.Ajax.disableCaching = false;

// Store for user logins, retrieved from database
var userlogins = new Ext.data.Store({
    reader: new Ext.data.JsonReader({
        fields: ['UserLogin'],
        root: 'result'
    }),
    proxy: new Ext.data.HttpProxy({
        url: '/index.php/start/fetchalluserloginsdb.php',
        method: 'POST'
    }),
    autoLoad: true
});

// Store for latest news, retrieved from database
var latestnews = new Ext.data.Store({
    reader: new Ext.data.JsonReader({
        root: 'news',
        fields: [
            {name: 'NewsDate', type: 'date', dateFormat: 'Y-m-d H:i:s'},
            {name: 'NewsTitle'},
            {name: 'NewsContent'}
        ]
    }),

    proxy: new Ext.data.HttpProxy({
        url: '/index.php/start/fetchnews.php',
        method: 'POST'
    }),
    autoLoad: true
});


Ext.onReady(function(){

    Ext.QuickTips.init();

    Ext.form.Field.prototype.msgTarget = 'side';
    // Usamos un FormPanel para crear la caja de Login

    var loginpanel = new Ext.FormPanel({
        labelWidth: 80,
        url: "index.php/start/authenticate.php",
        frame: true,
        title: 'Iniciar sesion',

        width: 230,
        padding: 10,
        defaultType: 'textfield',
        monitorValid: true,
        items: [
        {
            xtype: 'combo',
            vtype: 'alphanum',
            name: 'userlogin',
            fieldLabel: 'Usuario',
            mode: 'local',
            store: userlogins,
            displayField:'UserLogin',
            width: 120
        },{
            fieldLabel: 'Clave',
            name: 'password',
            inputType: 'password',
            allowBlank: false,
            width: 120
        }],
        buttons: [{
            text: 'Inicio',
            formBind: true,
            handler: function()
            {
                loginpanel.getForm().submit({
                    method: 'POST',
                    waitTitle: 'Autenticando..',
                    waitMsg: 'Enviando datos...',

                    success: function()
                    {
                        var redirect = "../desktop/desktop.html";
                        window.location = redirect;

                    },
                    failure: function(form, action)
                    // Pero si falla
                    {
                        if (action.failureType == 'server')
                        {
                            obj = Ext.util.JSON.decode(action.response.responseText);
                            Ext.Msg.alert('Error de autenticacion', obj.errors.reason);
                            // Le decimos al usuario que el logueo fall� y le damos el motivo
                        }
                        else
                        {
                            Ext.Msg.alert('Ouch!', 'el servidor no contesta : ' + action.response.responseText);
                            // O bien si hubo alg�n error en el sistema
                        }
                        loginpanel.getForm().reset();
                    }
                });
            }
        }]
    });

    var newspanelgridview = new Ext.grid.GridView({
                forceFit: true
        });

    var newspanelcolmodel = new Ext.grid.ColumnModel([
        {
            header: "Fecha",
                        width: 200,
            renderer: Ext.util.Format.dateRenderer('l j \\de F'),
            sortable: true,
            dataIndex: 'NewsDate'
        },{
            header: "Hora",
                        width: 60,
            renderer: Ext.util.Format.dateRenderer('g:i A'),
            sortable: false,
                        menuDisabled: true,
            dataIndex: 'NewsDate'
        },{
            header: "Titulo",
                        width: 200,
            sortable: false,
                        renderer: columnWrap,
                        menuDisabled: true,
            dataIndex: 'NewsTitle'
        },{
            header: "Contenido",
                        width: 300,
            sortable: false,
                        renderer: columnWrap,
                        menuDisabled: true,
            dataIndex: 'NewsContent'
        }
    ]);

    var newspanelselmodel = new Ext.grid.RowSelectionModel({
       singleSelect: true
    });

    var newspanel = new Ext.grid.GridPanel({
       frame:true,
       title: 'Noticias',
       width: 780,
       height: 200,
       store: latestnews,
       view: newspanelgridview,
       colModel: newspanelcolmodel,
       selModel: newspanelselmodel,
       enableColumnMove: false
    });


    // Usamos un Window para mostrar el Login en una ventanita

    var win = new Ext.Window(
        {
            layout: 'auto',
            title: 'TurnStat 3',
            width: 800,
            //height: 400,
                        autoHeight: true,
            closable: false,
            resizable: false,
            draggable: false,
            plain: true,
            items: [loginpanel,newspanel],
            buttonAlign: 'center',
            fbar: [{
                xtype: 'label',
                text: 'Desarrollado por Grupo DyD Ltda. Copyright 2010'
                }]
        }
    );
    win.show();
});