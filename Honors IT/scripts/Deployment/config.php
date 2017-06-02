<?php

$conf['index_page'] = 'index.php?';

$conf['subdirectory'] = '/reporting/';

$conf['dashboard_layout'] = array(
                array('client', 'munki', 'disk_report'),
                array('pending', 'pending_munki', 'pending_apple'),
                array('messages','modified_computernames'),
                array('manifests','munki_versions'),
                array('duplicated_computernames','new_clients'),
                array('registered_clients'),
                array('filevault', 'smart_status', 'bound_to_ds'),
                array('wifi_state','gatekeeper','uptime'),
                array('sip','printer'),
                array('app')
                );

$conf['modules'] = array('ard','bluetooth',
                'certificate','deploystudio','directory_service',
                'disk_report','displays_info','fan_temps','filevault_status',
                'gpu','gsx','installhistory','inventory','localadmin',
                'managedinstalls','munkiinfo','munkireport',
                'munkireportinfo','network','network_shares','power','printer',
                'profile','sccm_status','security','softwareupdate','usb',
                'user_sessions','warranty','wifi'
                );

$conf['temperature_unit'] = 'F';

$conf['hide_inactive_modules'] = TRUE;

$conf['apps_to_track'] = array('Google Chrome', 'Flash Player',
                'DeployStudio Admin', 'Atom', 'Identity Finder',
                'RStudio', 'Copy Storage Sharp', 'FileMaker Pro',
                'SourceTree', 'Remote Desktop', 'Microsoft Word',
                'Microsoft PowerPoint', 'Microsoft Excel',
                'Microsoft Outlook', 'MunkiAdmin'
                );

$auth_config['hcadmin'] = '$P$BQyrKziZQb.q5lxgGZMM3Yp/jmKfeY/';

$conf['allow_migrations'] = TRUE;
