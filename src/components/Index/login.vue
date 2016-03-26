<style></style>

<template>
	<div class="admin-content">
		<form class="am-form">
			<fieldset>
				<legend>后台管理员登录</legend>

				<div class="am-form-group">
					<label for="doc-ipt-text-1">用户名</label>
					<input type="text" class="" id="doc-ipt-text-1" name="username" placeholder="输入管理员账户" v-model="user.username"></div>

				<div class="am-form-group">
					<label for="doc-ipt-pwd-1">密码</label>
					<input type="password" class="" id="doc-ipt-pwd-1" placeholder="输入密码" name="password" v-model="user.password"></div>

				<p>
					<button type="button" class="am-btn am-btn-default" @click="doLogin">提交</button>
				</p>
			</fieldset>
		</form>
	</div>
</template>

<script>
module.exports = {
	data: function() {
		return {
			user: {
			}
		};
	},
	methods: {
		doLogin: function() {
			this.$http.post('login', this.user).then(function(res) {
				sessionStorage.setItem('user', res.data.username);
				this.$dispatch('doLogin');
				this.$route.router.go({
					path: '/'
				});
			}, function(err) {
				alert(err.data.message);
			});
		}
	}
};
</script>