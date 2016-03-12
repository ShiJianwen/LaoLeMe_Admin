<style>
	.search-suggest ul {
		list-style-type: none;
		padding-left: 0;
		border: 1px solid;
		border-top: none;
	}
	.search-suggest ul li {
		cursor: pointer;
		text-indent: 7px;
	}
	.search-suggest ul li:hover {
		background-color: gray;
	}
</style>
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
							<div class="am-u-sm-4 am-u-md-2 am-text-right">店家</div>
							<div class="am-u-sm-8 am-u-md-10">
								<input type="text" class="am-input-sm" v-model="restaurant.boss" disabled></div>
							<!-- <div class="am-hide-sm-only am-u-md-6">*必填，不可重复</div> -->
						</div>
						<div class="am-g am-margin-top">
							<div class="am-u-sm-4 am-u-md-2 am-text-right">店铺名</div>
							<div class="am-u-sm-8 am-u-md-10">
								<input type="text" class="am-input-sm" v-model="restaurant.name"></div>
							<!-- <div class="am-hide-sm-only am-u-md-6">*必填，不可重复</div> -->
						</div>

						<!-- <div class="am-g am-margin-top">
							<div class="am-u-sm-4 am-u-md-2 am-text-right">密码</div>
							<div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
								<input type="text" class="am-input-sm" v-model="password"></div>
						</div> -->

						<!-- <div class="am-g am-margin-top">
							<div class="am-u-sm-4 am-u-md-2 am-text-right">姓名</div>
							<div class="am-u-sm-8 am-u-md-4">
								<input type="text" class="am-input-sm" v-model="realname"></div>
							<div class="am-hide-sm-only am-u-md-6">选填</div>
						</div> -->
						<div class="am-g am-margin-top-sm">
							<div class="am-u-sm-12 am-u-md-2 am-text-right admin-form-text">地址</div>
							
							<div class="am-u-sm-12 am-u-md-10">
								<input type="text" class="am-input-sm" id="inputaddr" v-model="restaurant.addr" autocomplete="on" @change="geoCoder">
								<div class="search-suggest">
									<ul v-if="suggestions.length">
										<li v-for="suggestion in suggestions" @click="this.addr=suggesstion.address">
											{{suggestion.address}}
										</li>
									</ul>
								</div>
							</div>
						</div>
						<div class="am-g am-margin-top">
							<div class="am-u-sm-4 am-u-md-2 am-text-right">店铺类型</div>
							<div class="am-u-sm-8 am-u-md-10">
								<select name="" id="" v-model="restaurant.categories">
									<option value="{{categories.id}}" v-for="categories in categorieslist">{{categories.name}}</option>
								</select>
							</div>
						</div>
						<div class="am-g am-margin-top-sm">
							<div class="am-u-sm-12 am-u-md-2 am-text-right admin-form-text">送餐范围（千米）</div>
							<div class="am-u-sm-12 am-u-md-10">
								<input type="text" class="am-input-sm" v-model="restaurant.service_radius">
							</div>
						</div>
						

					</form>
				</div>
			</div>
		</div>

		<div class="am-margin">
			<button type="button" class="am-btn am-btn-primary am-btn-xs" @click="addNewRestaurant">提交保存</button>
			<button type="button" class="am-btn am-btn-primary am-btn-xs">放弃保存</button>
		</div>
	</div>
	<!-- content end -->
</template>

<script>
	module.exports = {
		data: function() {
			return {
				// city: '梅州市'
				suggestions: [],
				categorieslist: [],
				restaurant: {
					boss: ''
				}
			};
		},
		ready: function() {
			this.restaurant.boss = this.$route.params.bossId;
			console.log(this.restaurant.boss);
			// this.$http.get('helper/address').then(function(res) {
			// 	var data = JSON.parse(res.data.result);
			// 	if(data.status === 200) {
			// 		this.city = data.result.ad_info.city;
			// 	} else {
			// 		console.log(data);
			// 	}
				
			// }, function(err) {
			// 	console.log(err);
			// });
			this.$http.get('categories').then(function(res) {
				this.categorieslist = res.data.result;
			});
		},
		methods: {
			getSuggestion: function() {
				var data = {
					region: this.city,
					keyword: this.addr,
				};
				this.$http.get('helper/searchsuggest', data).then(function(res) {
					var result = JSON.parse(res.data.result);
					this.suggestions = result.data;
					console.log(result.data[0]);
				});
				
			},
			geoCoder: function() {
				var data = {
					address: encodeURIComponent(this.restaurant.addr)
				};
				this.$http.get('helper/geocoder', data).then(function(res) {
					var location = JSON.parse(res.data.result);
					this.restaurant.lat = location.result.location.lat;
					this.restaurant.lng = location.result.location.lng;
					console.log(JSON.parse(res.data.result));
				}, function(err) {
					console.log(err);
				});
			},
			addNewRestaurant: function() {
				this.$http.post('restaurant', this.restaurant).then(function(res) {
					console.log(res.data);
					alert('操作成功');
					this.$route.router.go({
						name: 'boss'
					});
				}, function(err) {
					console.log(err);
				});
			}
		}
	};
</script>