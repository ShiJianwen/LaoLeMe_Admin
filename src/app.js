var Vue = require('vue');
var app = Vue.extend({});
var VueRouter = require('vue-router');
Vue.use(VueRouter);
Vue.use(require('vue-resource'));
Vue.http.options.root = 'http://laoleme.duapp.com/api/v1';
var router = new VueRouter({
    hashbang: true,
    history: false,
    saveScrollPosition: true,
    transitionOnLoad: true
});

require('./router')(router);

router.start(app, "body");