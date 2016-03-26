<template>
	<!-- content start -->
	<div class="admin-content">

		<div class="am-cf am-padding">
			<div class="am-fl am-cf"> <strong class="am-text-primary am-text-lg">表格</strong>
				/
				<small>Table</small>
			</div>
		</div>

		<div class="am-g">
			<div class="am-u-sm-12 am-u-md-6">
				<div class="am-btn-toolbar">
					<div class="am-btn-group am-btn-group-xs">
						<button type="button" class="am-btn am-btn-default" v-link="{path: '/addboss'}">
							<span class="am-icon-plus"></span>
							新增
						</button>
						<button type="button" class="am-btn am-btn-default">
							<span class="am-icon-save"></span>
							保存
						</button>
						<button type="button" class="am-btn am-btn-default">
							<span class="am-icon-archive"></span>
							审核
						</button>
						<button type="button" class="am-btn am-btn-default">
							<span class="am-icon-trash-o"></span>
							删除
						</button>
					</div>
				</div>
			</div>
			<div class="am-u-sm-12 am-u-md-3">
				<div class="am-form-group">
					<select v-model="sort_type" @change="refreshPage">
						<option value=" " selected="true">所有类别</option>
						<option value="1" >已开店</option>
						<option value="2" >未开店</option>
						<!-- <option value="option3">笔记本电脑</option>
						<option value="option3">平板电脑</option>
						<option value="option3">只能手机</option>
						<option value="option3">超极本</option> -->
					</select>
				</div>
			</div>
			<div class="am-u-sm-12 am-u-md-3">
				<div class="am-input-group am-input-group-sm">
					<input type="text" class="am-form-field">
					<span class="am-input-group-btn">
						<button class="am-btn am-btn-default" type="button">搜索</button>
					</span>
				</div>
			</div>
		</div>

		<div class="am-g">
			<div class="am-u-sm-12">
				<form class="am-form">
					<table class="am-table am-table-striped am-table-hover table-main">
						<thead>
							<tr>
								<th class="table-check">
									<input type="checkbox" />
								</th>
								<th class="table-id">ID</th>
								<th class="table-title">姓名</th>
								<th class="table-type">性别</th>
								<th class="table-author am-hide-sm-only">电话</th>
								<th class="table-type">身份证号</th>
								<th class="table-date am-hide-sm-only">地址</th>
								<th class="table-set">操作</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="user in bosses">
								<td>
									<input type="checkbox" />
								</td>
								<td>{{user.id}}</td>
								<td>
									<a>{{user.realname}}</a>
								</td>
								<td>{{user.sex}}</td>
								<td class="am-hide-sm-only">{{user.phone}}</td>
								<td>{{user.idcard}}</td>
								<td class="am-hide-sm-only">{{user.addr}}</td>
								<td>
									<div class="am-btn-toolbar">
										<div class="am-btn-group am-btn-group-xs">
											<button class="am-btn am-btn-default am-btn-xs am-text-secondary">
												<span class="am-icon-pencil-square-o"></span>
												编辑
											</button>
											<button class="am-btn am-btn-default am-btn-xs am-hide-sm-only" v-if="sort_type==='1'">
												<span class="am-icon-copy"></span>
												进入店铺
											</button>
											<button class="am-btn am-btn-default am-btn-xs am-hide-sm-only" v-if="sort_type==='2'" v-link="{name: 'addrestaurant', params: {bossId: user.id}}">
												<span class="am-icon-copy"></span>
												开店
											</button>
											<button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" @click="deleteBoss(user.id)">
												<span class="am-icon-trash-o"></span>
												删除
											</button>
										</div>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="am-cf">
						共 {{bosses.length}} 条记录
						<div class="am-fr">
							<ul class="am-pagination">
								<li :class="{'am-disabled': this.pagenum==1}">
									<a @click="loadPrevPage">«</a>
								</li>
								<li :class="{'am-disabled': this.bosses.length<10}">
									<a @click="loadNextPage">»</a>
								</li>
							</ul>
						</div>
					</div>
					<hr />
					<p>注：.....</p>
				</form>
			</div>

		</div>
	</div>
	<!-- content end -->
</template>

<script>
	module.exports = {
		data: function() {
			return {
				bosses: [],
				pagenum: 1,
				perpage: 10,
				sort_type: ''
			};
		},
		ready: function() {
			var data = {
				offset: 0,
				isBoss: this.sort_type
			};
			this.$http.get('boss', data).then(function(res) {
				this.bosses = res.data.result;
				console.log(res.data);
			}, function(err) {
				if(err.status === 401) {
					alert('请先登录');
					this.$route.router.go({
						path: '/login'
					});
				}
			});
		},
		methods: {
			refreshPage: function() {
				var data = {
					offset: 0,
					isBoss: this.sort_type
				};
				this.$http.get('boss', data).then(function(res) {
					this.bosses = res.data.result;
					console.log(res.data);
				}, function(err) {});
			},
			loadNextPage: function() {
				var data = {
					offset: this.pagenum*this.perpage,
					isBoss: this.sort_type
				};
				this.$http.get('boss', data).then(function(res) {
					this.bosses = res.data.result;
					this.pagenum++;
				}, function(err) {});
			},
			loadPrevPage: function() {
				var data = {
					offset: (this.pagenum-2).this.perpage,
					isBoss: this.sort_type
				};
				this.$http.get('boss', data).then(function(res) {
					this.bosses = res.data.result;
					this.pagenum--;
				}, function(err) {});
			},
			deleteBoss: function(bid) {
				if(confirm('确定要删除？')) {
					this.$http.delete('boss/'+bid).then(function(res) {
						alert('删除成功');
						this.$route.router.go({
							name: 'boss'
						});
					}, function(err) {});
				}
			}
		}
	};
</script>