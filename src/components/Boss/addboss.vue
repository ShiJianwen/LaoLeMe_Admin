<template>
	<!-- content start -->
	<div class="admin-content">

		<div class="am-cf am-padding">
			<div class="am-fl am-cf"> <strong class="am-text-primary am-text-lg">表单</strong>
				/
				<small>form</small>
			</div>
		</div>

		<div class="am-tabs am-margin" data-am-tabs>
			<ul class="am-tabs-nav am-nav am-nav-tabs">
				<li class="am-active">
					<a href="#tab2">基本信息</a>
				</li>

			</ul>

			<div class="am-tabs-bd">
				<div class="am-tab-panel am-fade am-in am-active" id="tab2">
					<form class="am-form">
						<div class="am-g am-margin-top">
							<div class="am-u-sm-4 am-u-md-2 am-text-right">手机号</div>
							<div class="am-u-sm-8 am-u-md-4">
								<input type="text" class="am-input-sm" v-model="phone"></div>
							<div class="am-hide-sm-only am-u-md-6">*必填，不可重复</div>
						</div>

						<div class="am-g am-margin-top">
							<div class="am-u-sm-4 am-u-md-2 am-text-right">密码</div>
							<div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
								<input type="text" class="am-input-sm" v-model="password"></div>
						</div>

						<div class="am-g am-margin-top">
							<div class="am-u-sm-4 am-u-md-2 am-text-right">姓名</div>
							<div class="am-u-sm-8 am-u-md-4">
								<input type="text" class="am-input-sm" v-model="realname"></div>
							<div class="am-hide-sm-only am-u-md-6">选填</div>
						</div>

						<div class="am-g am-margin-top">
							<div class="am-u-sm-4 am-u-md-2 am-text-right">性别</div>
							<div class="am-u-sm-8 am-u-md-10">
								<label class="am-radio-inline">
									<input type="radio" name="radio10" value="男" data-am-ucheck v-model="sex">男</label>
								<label class="am-radio-inline">
									<input type="radio" name="radio10" value="女" data-am-ucheck v-model="sex">女</label>
							</div>
							<!-- <div class="am-u-sm-12 am-u-md-6">不填写则自动截取内容前255字符</div> -->
						</div>
						<div class="am-g am-margin-top-sm">
							<div class="am-u-sm-12 am-u-md-2 am-text-right admin-form-text">身份证号</div>
							<div class="am-u-sm-12 am-u-md-10">
								<input type="text" class="am-input-sm" v-model="idcard">
							</div>
						</div>
						<div class="am-g am-margin-top-sm">
							<div class="am-u-sm-12 am-u-md-2 am-text-right admin-form-text">地址</div>
							<div class="am-u-sm-12 am-u-md-10">
								<input type="text" class="am-input-sm" v-model="addr">
							</div>
						</div>

					</form>
				</div>
			</div>
		</div>

		<div class="am-margin">
			<button type="button" class="am-btn am-btn-primary am-btn-xs" @click="addNewBoss">提交保存</button>
			<button type="button" class="am-btn am-btn-primary am-btn-xs">放弃保存</button>
		</div>
	</div>
	<!-- content end -->
</template>

<script>
	module.exports = {
		methods: {
			addNewBoss: function() {
				var data = {
					phone: this.phone,
					password: this.password,
					realname: this.realname,
					sex: this.sex,
					idcard: this.idcard,
					addr: this.addr
				};
				this.$http.post('boss', data).then(function(res) {
					alert('添加成功');
					this.$route.router.go({
						name: 'boss'
					});
				}, function() {});
			}
		}
	};
</script>