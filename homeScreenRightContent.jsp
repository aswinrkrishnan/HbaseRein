<%@ taglib prefix="s" uri="/struts-tags"%>
<script>
	$(function() {

		$('#smartSearch').bind(
				'change keydown keyup',
				function() {
					if ($(this).val() == null || $(this).val() == '') {
						$(".tableList").parent().show();
					} else {
						$(".tableList:contains('" + $(this).val() + "')")
								.parent().show();
						$(".tableList:not(:contains('" + $(this).val() + "'))")
								.parent().hide();
					}
				});

		var selectedTable;
		var familyList = [];
		$(".colVal_tb").hide();
		$(".panes > div").hide();
		
		$("ul.tabs li a").click(function() {
			var divId = $(this).parent().attr('id')
			var displayDiv = "#" + divId + "Content";
			if ($(displayDiv).is(":hidden")) {
				$(".panes > div").hide();
				$(displayDiv).slideDown();
			}
		});
		$(".tabs > li a").click(function(){
			$(".tabs > li a").removeClass("selected");
			$(this).addClass("selected");
		});
		
		$(".tableList").click(
				function() {
					$(".panes > div").hide();
					$("#MetaInfoContent").slideDown();
					selectedTable = $(this).text();
					$.ajax({
						url : "fetchTableMetaInfo",
						type : 'POST',
						data : {
							"selectedTable" : selectedTable,
						},
						dataType : 'json',
						mimeType : 'application/json',
						success : function(response) {
							$("#colFamilies ul").empty();
							$("#endKeyStrings ul").empty();
							$("#startKeyStrings ul").empty();
							familyList = [];
							$.each(response.colFamNames, function(i, val) {
								if (val != null && val != "") {
									$("#colFamilies ul").append(
											"<li>" + val + "</li>");
									familyList[i] = val;
								}
							});
							$.each(response.endKeyStrings, function(i, val) {
								if (val != null && val != "") {
									$("#endKeyStrings ul").append(
											"<li>" + val + "</li>");
								}
							});
							$.each(response.startKeyStrings, function(i, val) {
								if (val != null && val != "") {
									$("#startKeyStrings ul").append(
											"<li>" + val + "</li>");
								}
							});
							$("#dataTable").find("tr:gt(0)").remove();
						},
						error : function(data, status, er) {
							alert("Error : " + data + " Status : " + status
									+ " Err : " + er);
						}
					});
					$("#RightContentHeading").text("Table: " + selectedTable);
					$(".tabs > li a").removeClass("selected");
					$("#MetaInfo a").addClass("selected");
				});
		$("#Browse a")
				.click(
						function() {
							$
									.ajax({
										url : "fetchTableData",
										type : 'POST',
										data : {
											"selectedTable" : selectedTable,
										},
										dataType : 'json',
										mimeType : 'application/json',
										success : function(response) {

											$("#dataTable").find("tr:gt(0)")
													.remove();
											$
													.each(
															response,
															function(i, val) {
																$
																		.each(
																				val,
																				function(
																						innerKey,
																						innerValue) {
																					$(
																							'#dataTable tr:last')
																							.after(
																									'<tr><td class="rowKey">'
																											+ i
																											+ '</td><td class="colFamily">'
																											+ innerValue.colFamily
																											+ '</td><td class="colQualifier">'
																											+ innerValue.qualifier
																											+ '</td><td class="colValue"><div class="spanValue">'
																											+ innerValue.value
																											+ '</div><input class="colVal_tb" type="text" /></td><td class="add"></td><td class="edit"></td><td class="delete"></td></tr>');
																				});
															});
										},
										error : function(data, status, er) {
											alert("Error : " + data
													+ " Status : " + status
													+ " Err : " + er);
										}
									});
							});

		$("#Insert a").click(
				function() {
					$("#colFamily_select").empty();
					$.each(familyList, function(i, val) {
						if (val != null && val != "") {
							$("#colFamily_select").append(
									"<option>" + val + "</option>");
						}
					});					
				});

		$("#submit_btn").click(
				function() {
					if ($("#rowKey_tb").val() != ""
							&& $("#colFamily_select").val() != ""
							&& $("#quailifier_tb").val() != ""
							&& $("#value_tb").val()) {
						$.ajax({
							url : "insertRow",
							type : 'POST',
							data : {
								"selectedTable" : selectedTable,
								"rowKey" : $("#rowKey_tb").val(),
								"columnFamily" : $("#colFamily_select").val(),
								"columnQualifier" : $("#quailifier_tb").val(),
								"columnValue" : $("#value_tb").val()
							},
							dataType : 'json',
							mimeType : 'application/json',
							success : function(response) {
								$("#rowKey_tb").val("");
								$("#colFamily_select").val("");
								$("#quailifier_tb").val("");
								$("#value_tb").val("");
								displayMessage("Row inserted");
							},
							error : function(data, status, er) {
								alert("Error : " + data + " Status : " + status
										+ " Err : " + er);
							}
						});
					} else {
						alert("Enter Values in all fields");
					}
				});
		$("#submit_search_btn")
				.click(
						function() {
							$
									.ajax({
										url : "searchTable",
										type : 'POST',
										data : {
											"selectedTable" : selectedTable,
											"rowKey" : $("#rowKey_search_tb")
													.val(),
											"columnQualifier" : $(
													"#quailifier_search_tb")
													.val(),
											"columnValue" : $(
													"#value_search_tb").val(),
											"rowKeyCondn" : $("#row_search")
													.val(),
											"columnQualifierCondn" : $(
													"#qualifier_search").val(),
											"columnValueCondn" : $(
													"#value_search").val()
										},
										dataType : 'json',
										mimeType : 'application/json',
										success : function(response) {
											$(".panes > div").hide();
											$("#BrowseContent").slideDown();
											$("#dataTable").find("tr:gt(0)")
													.remove();
											$
													.each(
															response,
															function(i, val) {
																$
																		.each(
																				val,
																				function(
																						innerKey,
																						innerValue) {
																					$(
																							'#dataTable tr:last')
																							.after(
																									'<tr><td class="rowKey">'
																											+ i
																											+ '</td><td class="colFamily">'
																											+ innerValue.colFamily
																											+ '</td><td class="colQualifier">'
																											+ innerValue.qualifier
																											+ '</td><td class="colValue"><div class="spanValue">'
																											+ innerValue.value
																											+ '</div><input class="colVal_tb" type="text" /></td><td class="add"></td><td class="edit"></td><td class="delete"></td></tr>');
																				});
															});
										},
										error : function(data, status, er) {
											alert("Error : " + data
													+ " Status : " + status
													+ " Err : " + er);
										}
									});
						});

		$('body')
				.on(
						'click',
						".edit",
						function(event) {
							event.preventDefault();
							if ($(this).parent().find(".spanValue").text() != null
									&& $(this).parent().find(".spanValue")
											.text() != "") {
								var colValue = $(this).parent().find(
										".spanValue").text();
								$(this).parent().find(".spanValue").text("");
								$(this).parent().find(".colVal_tb").show();
								$(this).parent().find(".colVal_tb").val(
										colValue);
								$(this).removeClass("edit");
								$(this).addClass("save");
							}
						});
		$('body')
				.on(
						'click',
						".add",
						function(event) {
							event.preventDefault();
							var rowKey = $(this).parent().find(".rowKey")
									.text();
							var colFamily = $(this).parent().find(".colFamily")
									.text();
							var colQualifier = $(this).parent().find(
									".colQualifier").text();
							var colValue = $(this).parent().find(".colValue")
									.text();

							var selectFamily = "<select class='selectFamily'>";
							$.each(familyList, function(i, val) {
								if (val != null && val != "") {
									if (val == colFamily) {
										selectFamily += "<option selected>"
												+ val + "</option>";
									} else {
										selectFamily += "<option>" + val
												+ "</option>";
									}
								}
							});
							selectFamily += "</select>";

							$(this)
									.parent()
									.after(
											'<tr><td><input style="width:'
													+ $("#rowKeyHead").width()
													+ 'px" type="text" class="addRowKey" value="'
													+ rowKey
													+ '"/></td>'
													+ '<td>'
													+ selectFamily
													+ '</td>'
													+ '<td><input style="width:'
													+ $("#qualifierHead")
															.width()
													+ 'px" type="text" class="addColQualifier" value="'
													+ colQualifier
													+ '"/></td>'
													+ '<td><input style="width:'
													+ $("#valueHead").width()
													+ 'px" type="text" class="addColValue" value="'
													+ colValue
													+ '"/></td>'
													+ '<td class="addSave"></td><td></td><td></td></tr>');
							$(this).removeClass("add");
							$(this).addClass("addPlaceHolder");
						});
		$('body')
				.on(
						'click',
						".addSave",
						function(event) {
							event.preventDefault();
							var rowKey = $(this).parent().find(".addRowKey")
									.val();
							var colFamily = $(this).parent().find(
									".selectFamily").val();
							var colQualifier = $(this).parent().find(
									".addColQualifier").val();
							var colValue = $(this).parent()
									.find(".addColValue").val();

							$.ajax({
								url : "insertRow",
								type : 'POST',
								data : {
									"selectedTable" : selectedTable,
									"rowKey" : rowKey,
									"columnFamily" : colFamily,
									"columnQualifier" : colQualifier,
									"columnValue" : colValue
								},
								dataType : 'json',
								mimeType : 'application/json',
								success : function(response) {
									displayMessage("Row Added");
								},
								error : function(data, status, er) {
									alert("Error : " + data + " Status : "
											+ status + " Err : " + er);
								}
							});

							$(this).parent().hide();
							$(this)
									.parent()
									.after(
											'<tr><td  class="rowKey" style="width:'
													+ $("#rowKeyHead").width()
													+ 'px" >'
													+ rowKey
													+ '</td>'
													+ '<td  class="colFamily">'
													+ colFamily
													+ '</td>'
													+ '<td  class="colQualifier" style="width:'
													+ $("#qualifierHead")
															.width()
													+ 'px" >'
													+ colQualifier
													+ '</td>'
													+ '<td  class="colValue" style="width:'
													+ $("#valueHead").width()
													+ 'px" ><div class="spanValue">'
													+ colValue
													+ '</div><input class="colVal_tb" type="text" /></td>'
													+ '<td class="add"></td><td class="edit"></td><td class="delete"></td></tr>');

							$(this).parent().prev('tr').find(".addPlaceHolder")
									.addClass("add");
							$(this).parent().prev('tr').find(".addPlaceHolder")
									.removeClass("addPlaceHolder");

						});
		$('body')
				.on(
						'click',
						".save",
						function(event) {
							event.preventDefault();
							if ($(this).parent().find(".colVal_tb").val() != null
									&& $(this).parent().find(".colVal_tb")
											.val() != "") {
								var colValue = $(this).parent().find(
										".colVal_tb").val();
								$.ajax({
									url : "insertRow",
									type : 'POST',
									data : {
										"selectedTable" : selectedTable,
										"rowKey" : $(this).parent().children(
												".rowKey").text(),
										"columnFamily" : $(this).parent()
												.children(".colFamily").text(),
										"columnQualifier" : $(this).parent()
												.children(".colQualifier")
												.text(),
										"columnValue" : colValue
									},
									dataType : 'json',
									mimeType : 'application/json',
									success : function(response) {
										displayMessage("Row Edited");
									},
									error : function(data, status, er) {
										alert("Error : " + data + " Status : "
												+ status + " Err : " + er);
									}
								});
								$(this).removeClass("save");
								$(this).addClass("edit");
								$(this).parent().find(".spanValue").text(
										colValue);
								$(this).parent().find(".colVal_tb").hide();
							}
						});
		$('body').on(
				'click',
				".delete",
				function(event) {
					event.preventDefault();
					var confirmDialog = confirm("Do you want to delete this? \n\nRow Key:"+$(this).parent().children(".rowKey").text()+"\tcolumnFamily:"+ $(this).parent().children(
					".colFamily").text()+"\columnQualifier:"+$(this).parent().children(
					".colQualifier").text());
					if(confirmDialog==true){
					$.ajax({
						url : "deleteRow",
						type : 'POST',
						data : {
							"selectedTable" : selectedTable,
							"rowKey" : $(this).parent().children(".rowKey")
									.text(),
							"columnFamily" : $(this).parent().children(
									".colFamily").text(),
							"columnQualifier" : $(this).parent().children(
									".colQualifier").text(),
						},
						dataType : 'json',
						mimeType : 'application/json',
						success : function(response) {
							displayMessage("Row Deleted");
						},
						error : function(data, status, er) {
							alert("Error : " + data + " Status : " + status
									+ " Err : " + er);
						}
					});
					$(this).parent().remove();}
				});
		function displayMessage(message) {
				$("#callOut").slideDown();
				$("#callOut").text(message);
				jQuery("#callOut").delay(6000);
				$("#callOut").slideUp();
		}
	});
</script>
<div class="rightcontent ">
	<div class="square_edged">
		<div class="h2" id="RightContentHeading">Decription</div>
		<div class="height535 overflowY">
			<div class="tabContainer">
				<ul class="tabs">
					<li id="MetaInfo"><a href="#">Meta Info</a></li>
					<li id="Browse"><a href="#">Browse</a></li>
					<li id="Insert"><a href="#">Insert</a></li>
					<li id="Search"><a href="#">Search</a></li>
				</ul>
				<div class="clear"></div>
				<div class="panes">
					<div id="MetaInfoContent">
						<div id="colFamilies" class="metaDiv">
							Column families
							<ul></ul>
						</div>
						<div id="endKeyStrings" class="metaDiv">
							End Key Strings
							<ul></ul>
						</div>
						<div id="startKeyStrings" class="metaDiv">
							Start Key Strings
							<ul></ul>
						</div>



					</div>
					<div id="BrowseContent">
						<div class="metaDiv">
							<table class="striped" id="dataTable">
								<tr>
									<th id="rowKeyHead">Row Key</th>
									<th>Col Family</th>
									<th id="qualifierHead">Qualifier</th>
									<th id="valueHead">Value</th>
									<th></th>
									<th></th>
									<th></th>

								</tr>
							</table>
						</div>
					</div>
					<div id="InsertContent">
						<div class="metaDiv">
							Insert
							<table class="striped" id="insertTable" width="400px">
								<tr>
									<td>Row Key</td>
									<td><input id="rowKey_tb" type="text" /></td>
								</tr>
								<tr>
									<td>Qualifier</td>
									<td><select id="colFamily_select" /><input
										id="quailifier_tb" type="text" /></td>
								</tr>
								<tr>
									<td>Value</td>
									<td><input id="value_tb" type="text" /></td>
								</tr>
								<tr>
									<td></td>
									<td><input id="submit_btn" type="submit" value="Insert" /></td>
								</tr>
							</table>
						</div>

					</div>
					<div id="SearchContent">
						<div class="metaDiv">
							Search
							<table class="striped" id="insertTable">
								<tr>
									<td>Row Key</td>
									<td><select id="row_search">
											<option value="startsWith">Starts with</option>
											<option value="equals">Equals</option>
											<option value="contains">Contains</option>
									</select></td>
									<td><input id="rowKey_search_tb" type="text" /></td>
								</tr>
								<tr>
									<td>Qualifier</td>
									<td><select id="qualifier_search">
											<option value="startsWith">Starts with</option>
											<option value="equals">Equals</option>
											<option value="contains">Contains</option>
									</select></td>
									<td><input id="quailifier_search_tb" type="text" /></td>
								</tr>
								<tr>
									<td>Value</td>
									<td><select id="value_search">
											<option value="equals">Equals</option>
											<option value="contains">Contains</option>
									</select></td>
									<td><input id="value_search_tb" type="text" /></td>
								</tr>
								<tr>
									<td></td>
									<td><input id="submit_search_btn" type="submit" /></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>

		</div>


	</div>

</div>

