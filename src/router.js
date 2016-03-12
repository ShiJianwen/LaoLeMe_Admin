var index = require('./components/Index/index.vue');
var userlist = require('./components/User/list.vue');
var adduser = require('./components/User/adduser.vue');
var bosslist = require('./components/Boss/list.vue');
var addboss = require('./components/Boss/addboss.vue');
var reslist = require('./components/Restaurant/list.vue');
var addres = require('./components/Restaurant/add.vue');
module.exports = function(router) {
	router.map({
		'/': {
			name: '首页',
			component: index,
			subRoutes: {
				'/user': {
					name: 'users',
					component: userlist
				},
				'/boss': {
					name: 'boss',
					component: bosslist
				},
				'/adduser': {
					component: adduser
				},
				'/addboss': {
					component: addboss
				},
				'/restaurant': {
					name: 'restaurant',
					component: reslist
				},
				'/addrestaurant/:bossId': {
					name: 'addrestaurant',
					component: addres
				}
			}
		}
	});
};