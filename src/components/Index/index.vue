<style>
	
</style>

<template>
	<headers></headers>
	<sidebar></sidebar>
</template>

<script>
	var headers = require('./header.vue');
	var sidebar = require('./sidebar.vue');
	module.exports = {
		components: {headers, sidebar},
		ready: function() {
			if(!sessionStorage.user) {
				this.$route.router.go({
					path: '/login'
				});
			}
		},
		events: {
			'doLogin': function() {
				this.$broadcast('loggedin');
			},
			'doLogout': function() {
				this.$broadcast('loggedout');
			}
		}
	};
</script>