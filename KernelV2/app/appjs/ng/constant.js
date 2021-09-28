'use strict';

angular.module('attuneKernel.constants', [])

.constant('APP_INFO', {
	'Name': 'Attune Kernel',
	'Version': 1.0
})
.constant('AUTHTOKEN', {
	'SESSION': 'X-XSRF-Session-Token',
	'FIELD': 'X-XSRF-Field-Token',
	'AJAX': 'X-XSRF-Ajax-Tokens'
})
.constant('VALIDATION', {})
.constant('ENV', {
	name: 'localhost',
	apiEndPoint: 'http://localhost/V2_Api/api/v1/',
	platformEndPoint: "http://localhost/LIS_V2/PlatformWebServices/ProfileService.asmx/"
})
.constant('ngAuthSettings', {
	clientId: 'LISKernel'
})
.constant('REFRESHINTERVAL', {
	tokenInterval: 200000
})
.constant('PRIVILEGE', {
	view: 1,
	create: 2,
	edit: 4,
	delete : 8,
	export: 16
	//,
	//selectall: this.view & this.create & this.edit & this.delete & this.export
});
