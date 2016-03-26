<template>
	<header class="am-topbar admin-header">
		<div class="am-topbar-brand"> <strong>捞了么</strong>
			<small>后台管理系统</small>
		</div>

		<button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}">
			<span class="am-sr-only">导航切换</span>
			<span class="am-icon-bars"></span>
		</button>

		<div class="am-collapse am-topbar-collapse" id="topbar-collapse">

			<ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
				<!-- <li>
					<a href="javascript:;">
						<span class="am-icon-envelope-o"></span>
						收件箱
						<span class="am-badge am-badge-warning">5</span>
					</a>
				</li> -->
				<li v-if="!user" v-link="{path: '/login'}">
					<a href="javascript:;">
						登录
					</a>
				</li>
				<li class="am-dropdown" data-am-dropdown v-if="user">
					<a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
						<span class="am-icon-users"></span>
						{{user}}
						<span class="am-icon-caret-down"></span>
					</a>
					<ul class="am-dropdown-content">
						<li @click="doLogout">
							<a href="#">
								<span class="am-icon-power-off"></span>
								退出
							</a>
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</header>
</template>
<script>
	module.exports = {
		data: function() {
			return {
				user: sessionStorage.user
			};
		},
		ready: function() {
			

		},
		methods: {
			doLogout: function() {
				this.$http.get('logout').then(function(res) {
					sessionStorage.removeItem('user');
					this.$dispatch('doLogout');
					this.user = null;
				}, function(err) {
					console.log(err);
				});
			}
		},
		events: {
			'loggedin': function() {
				console.log('header');
				this.user = sessionStorage.user;
			}
		}
	};
</script>