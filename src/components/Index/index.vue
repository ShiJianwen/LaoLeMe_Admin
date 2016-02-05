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
		components: {headers, sidebar}
	};
</script>