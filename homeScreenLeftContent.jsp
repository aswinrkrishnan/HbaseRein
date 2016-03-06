<%@ taglib prefix="s" uri="/struts-tags"%>

<div class="leftcontent ">
<div class="square_edged" >
		<div class="h2">Tables</div>
		<div class="smartSearchDiv"><input type="text" id="smartSearch" placeholder="Search Table" value="" /></div>
		<div class="height500 overflowY" >
		<table class="striped" id="tableList">
		<s:iterator value="tables">

			<tr>
			<td class="tableList"><s:property /></td>
			</tr>
			

		</s:iterator>
		</table>
		</div>
	</div>
</div>
