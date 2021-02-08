<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="esapi" uri="http://www.owasp.org/index.php/Category:OWASP_Enterprise_Security_API" %>

<style>
	.section {
		color: #fff;
		font-size: 16px;				
		background-color: #245077;
		margin-top: -11px;
		margin-bottom: -11px;
		margin-left: -18px;
		margin-right: -18px;
		border-top-left-radius: 5px;
		border-top-right-radius: 5px;
		padding: 10px;
		min-height: 40px;
	}
	
	.section a {
		color: #fff;
	}

	.sectionwithquestions {
		background-color: #efefef;
		border: 1px solid #ccc;
		padding-left: 18px;
		padding-right: 18px;
		padding-bottom: 11px;
		padding-top: 11px;
		margin-bottom: 20px;
		border-radius: 5px;
	}
	
	.sectioncontent {
		margin-top: 20px;
		margin-bottom: 0px;
	}
	
	.question {
		float: left;
		margin-right: 20px;
		margin-bottom: 20px;
		width: 300px;
		min-height: 315px;
		background-color: #fff;
		border: 1px solid #ccc;
		position: relative;
	}
	
	.question-title {
		padding: 5px;
		border-bottom: 1px solid #ccc;
		margin-bottom: 5px;
		font-weight: bold;
		height: 50px;
		overflow-y: hidden;
	}
	
	.greenanswer {	
		color: #0b0;
		margin-bottom: 5px;
	}
	
	.redanswer {
		color: #b00;
		margin-bottom: 5px;
	}
	
	.question-footer {
		padding: 5px;
		border-top: 1px solid #ccc;
		margin-top: 5px;
	}

	.no-graph-image {
		text-align: center;
		display: block;
		position: absolute;
		width: 100%;
		padding-top: 45px;
		color: #aaa;
	}

	.no-graph-image .glyphicon {
		font-size: 90px;
	}

</style>

	<div class="modal" id="delphi-chart-modal-start-page" data-backdrop="static">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-body">
					<h1><spring:message code="label.Statistics" /></h1>
				</div>
				<div class="modal-footer">
					<a class="btn btn-primary" data-dismiss="modal"><spring:message code="label.Close"/></a>
				</div>
			</div>
		</div>
	</div>

	<c:choose>
		<c:when test="${forpdf == null && responsive == null}">
			<div class="fullpageform" style="padding-top: 40px;">
		</c:when>
		<c:when test="${responsive != null}">
			<div style="padding-top: 40px;">
		</c:when>
		<c:otherwise>
			<div>
		</c:otherwise>
	</c:choose>
	
		<c:if test="${responsive == null}">
	
			<div class="right-area" style="z-index: 1; position: relative; float: right;">						
				<c:if test="${form.survey.logo != null && form.survey.logoInInfo}">
					<img style="max-width: 100%" src="<c:url value="/files/${form.survey.uniqueId}/${form.survey.logo.uid}" />" alt="logo" />
					<hr style="margin-top: 15px;" />
				</c:if>			
				
				<c:if test="${form.getLanguages().size() != 0}">		
					<label for="langSelectorRunner">
						<div class="linkstitle" style="margin-bottom: 5px;">${form.getMessage("label.Languages")}</div>	
					</label>
					<select id="langSelectorRunner" name="langSelectorRunner" onchange="changeLanguageSelectOption('${mode}')">	
					<c:forEach var="lang" items="${form.getLanguagesAlphabetical()}">
						<c:choose>
							<c:when test="${lang.value.code == form.language.code}">
								<option value="<esapi:encodeForHTML>${lang.value.code}</esapi:encodeForHTML>" selected="selected"><esapi:encodeForHTML>[${lang.value.code}] ${lang.value.name}</esapi:encodeForHTML></option>
							</c:when>
							<c:otherwise>
								<option value="<esapi:encodeForHTML>${lang.value.code}</esapi:encodeForHTML>"><esapi:encodeForHTML>[${lang.value.code}] ${lang.value.name}</esapi:encodeForHTML></option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					</select>							
					<hr style="margin-top: 15px;" />	
				</c:if>									
				
				<div id="contact-and-pdf" style="word-wrap: break-word;">
				
					<c:if test="${form.survey.contact != null}">
						<div class="linkstitle" style="margin-bottom: 5px;">${form.getMessage("label.Contact")}</div>
						
						<c:choose>
							<c:when test="${form.survey.contact.startsWith('form:')}">
								<a target="_blank" class="link visibleLink" data-toggle="tooltip" title="${form.getMessage("info.ContactForm")}" href="${contextpath}/runner/contactform/${form.survey.shortname}">${form.getMessage("label.ContactForm")}</a>
							</c:when>
							<c:when test="${form.survey.contact.contains('@')}">
								<i class="icon icon-envelope" style="vertical-align: middle"></i>
								<a class="link" href="mailto:<esapi:encodeForHTMLAttribute>${form.survey.contact}</esapi:encodeForHTMLAttribute>"><esapi:encodeForHTML>${form.survey.contact}</esapi:encodeForHTML></a>
							</c:when>
							<c:otherwise>
								<i class="icon icon-globe" style="vertical-align: middle"></i>
								<a target="_blank" class="link visiblelink" href="<esapi:encodeForHTMLAttribute>${form.survey.fixedContact}</esapi:encodeForHTMLAttribute>"><esapi:encodeForHTML>${form.survey.fixedContactLabel}</esapi:encodeForHTML></a>
							</c:otherwise>
						</c:choose>
					</c:if>
					
					<div class="linkstitle" style="margin-bottom: 5px;">${form.getMessage("label.Info")}</div>
					<a target="_blank" class="link visibleLink" data-toggle="tooltip" title="${form.getMessage("label.Delphi")}" href="${contextpath}/home/delphi">${form.getMessage("label.Delphi")}</a>
							
				</div>												
			</div>
		</c:if>
		
		<div style="padding: 20px">
			<c:if test="${form.survey.logo != null && !form.survey.logoInInfo}">
				<div style="max-width: 900px">
					<img src="<c:url value="/files/${form.survey.uniqueId}/${form.survey.logo.uid}" />" alt="logo" style="max-width: 900px;" />
				</div>
			</c:if>
		
			<div class="surveytitle">${form.survey.title}</div><br />
			
			<button class="btn btn-default" onclick="closeAll()">Close All</button>
			<button class="btn btn-default" onclick="openAll()">Open All</button>
		</div>
		
		<div style="clear: both"></div>
		
		<c:choose>
			<c:when test="${responsive == null}">	
				<div class="delphistartdiv">
			</c:when>
			<c:otherwise>
				<div>
			</c:otherwise>
		</c:choose>
		
			<input type="hidden" id="uniqueCode" name="originalUniqueCode" value="${uniqueCode}" />
			<input type="hidden" id="survey.id" value="${form.survey.id}" />
			<input type="hidden" id="language.code" value="${form.survey.language.code}" />
						
			<div id="sections">
				<!-- ko if: !loaded() -->
				<div>
					<img class="center" src="${contextpath}/resources/images/ajax-loader.gif"/>
				</div>
				<!-- /ko -->

				<!-- ko foreach: sections -->
				<div class="sectionwithquestions">

					<div class="section">
						<div style="float: right; margin-top: 4px; margin-right: 0px;">
							<a onclick="toggle(this);"><span class="glyphicon glyphicon-triangle-bottom"></span></a>
							<a style="display: none" onclick="toggle(this);"><span class="glyphicon glyphicon-triangle-left"></span></a>
						</div>
						<span data-bind="html: title"></span>
					</div>

					<div class="sectioncontent">

						<!-- ko foreach: questions -->
						<div class="question" data-bind="attr: {id: 'delphiquestion' + uid, 'data-uid': uid}">
							<div class="question-title">
								<span data-bind="html: sectionViewModel.niceTitle(title)"></span>
								<span style="display:none;" class="glyphicon glyphicon-resize-full delphi-chart-expand" onclick="loadDelphiModalStartPage(this)" data-toggle="tooltip" title="${form.getMessage("tooltip.ExpandChart")}"></span>
							</div>

							<div class="no-graph-image">
								<span class="glyphicon glyphicon-signal"></span><br />
								<span><spring:message code="info.NoData" /></span>
							</div>
							<div style="height: 200px;" class="delphi-chart-div">
								<canvas class='delphi-chart' width='300' height='200'></canvas>
							</div>

							<div class="question-footer">
								<!--  ko if: maxDistanceExceeded -->
									<div style="color: #f00; font-size: 30px; float: right;">
										<span style="cursor: pointer" data-toggle="tooltip" title="<spring:message code="info.MaxDistanceExceeded" />"><img style="max-width:24px;" src="<c:url value="/resources/images/warning24.png"/>" alt="max distance exceeded" /></span>
									</div>
								<!-- /ko -->							
							
								<!-- ko if: answer.length > 0 -->
								<div class="greenanswer"><spring:message code="info.YouAnswered" />: <span style="font-weight: bold" data-bind="html: sectionViewModel.niceAnswer(answer)"></span></div>
								
								<!-- ko if: $parents[1].unansweredMandatoryQuestions() == false -->								
								<a class="btn btn-xs btn-default" data-bind="attr: {href:'?startDelphi=true&surveylanguage=${form.language.code}&originalUniqueCode=${uniqueCode}#E' + id}"><spring:message code="label.EditAnswer" /></a>
								<!-- /ko -->
							
								<!-- /ko -->
								<!-- ko if: answer.length == 0 -->
								<div class="redanswer"><spring:message code="info.NotAnswered" /></div>
			
								<!-- ko if: $parents[1].unansweredMandatoryQuestions() == false -->
								<a class="btn btn-xs btn-primary" data-bind="attr: {href:'?startDelphi=true&surveylanguage=${form.language.code}&originalUniqueCode=${uniqueCode}#E' + id}"><spring:message code="label.Answer" /></a>
								<!-- /ko -->
						
								<!-- /ko -->
								<c:if test="${form.survey.isDelphiShowAnswers}">
									<!-- ko if: isDelphiShowAnswersAndStatisticsInstantly || answer.length > 0 -->
									<a class="btn btn-xs btn-default" onclick="openAnswersDialog(this);"><spring:message code="label.ShowAllAnswers" /></a>
									<!-- /ko -->
								</c:if>
								
							</div>
						</div>					
						<!-- /ko -->
						
						<div style="clear: both"></div>
					</div>
				</div>
				<!-- /ko -->
			</div>
			
			<div style="text-align: center">
				<a class="btn btn-primary" href="?startDelphi=true&surveylanguage=${form.language.code}&originalUniqueCode=${uniqueCode}"><spring:message code="label.Start" /></a>
			</div>
		
		</div>
		
		<div style="clear: both"></div>
	</div>

	<div class="modal answers-table-modal" data-backdrop="static">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header"><spring:message code="label.ResultsTable" /></div>
				<div class="modal-body">
					<div class="answers-table-modal-error"></div>
					<%@ include file="delphiAnswersTable.jsp" %>
				</div>
				<div class="modal-footer">
					<a class="btn btn-primary" data-dismiss="modal"><spring:message code="label.Close" /></a>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		const surveyId = ${form.survey.id};
		const errorDelphiTableContributionCouldNotBeChanged = "${form.getMessage("error.DelphiTableContributionCouldNotBeChanged")}";
		const errorDelphiTableContributionCouldNotBeDeleted = "${form.getMessage("error.DelphiTableContributionCouldNotBeDeleted")}";
		const errorDelphiTableContributionCouldNotBeSubmitted = "${form.getMessage("error.DelphiTableContributionCouldNotBeSubmitted")}";

		function openAnswersDialog(element) {
			$('.answers-table-modal-error').hide();
			$('.answers-table-modal').modal('show');

			const languageCode = "${form.language.code}";
			currentQuestionUidInModal = $(element).closest('.question').attr('data-uid');
			const uniqueCode = $('#uniqueCode').val();
			loadTableDataInner(languageCode, currentQuestionUidInModal, surveyId, uniqueCode, answersTableViewModel);
		}

		function changeLanguageSelectOption(mode) {
			window.location = "?surveylanguage=" + $('#langSelectorRunner').val();
		}
		
		function changeLanguageSelectHeader(mode, headerLang) {
			window.location = "?surveylanguage=" + headerLang;
		}
		
		function closeAll() {
			$(".glyphicon-triangle-bottom:visible").each(function(){
				toggle($(this).parent());
			});
		}
		
		function openAll() {
			$(".glyphicon-triangle-left:visible").each(function(){
				toggle($(this).parent());
			});
		}

		function saveDelphiCommentFromStartPage(element, reply) {

			$('.answers-table-modal-error').hide();

			const errorCallback = function() {
				$('.answers-table-modal-error').show();
				$('.answers-table-modal-error').text(errorDelphiTableContributionCouldNotBeSubmitted);
			}
			const successCallback = function() {
				const languageCode = "${form.language.code}";
				const answerSetUniqueCode = $('#uniqueCode').val();
				loadTableDataInner(languageCode, currentQuestionUidInModal, surveyId, answerSetUniqueCode, answersTableViewModel);
			}
			saveDelphiComment(element, answersTableViewModel, reply, currentQuestionUidInModal, surveyId, errorCallback,
				successCallback);
		}

		function saveChangedDelphiCommentFromStartPage(element, isReply) {

			$('.answers-table-modal-error').hide();

			const errorCallback = function() {
				$('.answers-table-modal-error').show();
				$('.answers-table-modal-error').text(errorDelphiTableContributionCouldNotBeChanged);
			}
			const successCallback = function() {
				const languageCode = "${form.language.code}";
				const answerSetUniqueCode = $('#uniqueCode').val();
				loadTableDataInner(languageCode, currentQuestionUidInModal, surveyId, answerSetUniqueCode, answersTableViewModel);
			}
			saveChangedDelphiComment(element, answersTableViewModel, isReply, errorCallback, successCallback);
		}

		function deleteDelphiCommentFromStartPage(element, isReply) {
			var dialog = $(element).closest(".delphi-table").find(".delete-confirmation-dialog");
			$(dialog).modal("show");

			var deleteButton = $(dialog).find(".delete-confirmation-dialog__confirmation-button");
			$(deleteButton).off("click");
			$(deleteButton).click(function () {
				$('.answers-table-modal-error').hide();

				const errorCallback = function () {
					$('.answers-table-modal-error').show();
					$('.answers-table-modal-error').text(errorDelphiTableContributionCouldNotBeDeleted);
				}

				const successCallback = function () {
					const languageCode = "${form.language.code}";
					const answerSetUniqueCode = $('#uniqueCode').val();
					loadTableDataInner(languageCode, currentQuestionUidInModal, surveyId, answerSetUniqueCode, answersTableViewModel);
				}

				$(dialog).modal("hide");
				deleteDelphiComment(element, answersTableViewModel, isReply, errorCallback, successCallback);
			});
			var cancelButton = $(dialog).find(".delete-confirmation-dialog__cancel-button");
			$(cancelButton).off("click");
			$(cancelButton).click(function () {
				$(dialog).modal("hide");
			});
		}
		
		function toggle(element)
		{
			$(element).closest('.sectionwithquestions').find(".sectioncontent").toggle();
			$(element).parent().find("a").toggle();
		}

		const answersTableViewModel = createNewDelphiBasicViewModel();

		const isDelphiShowAnswersAndStatisticsInstantly = ${form.survey.isDelphiShowAnswersAndStatisticsInstantly};

		let currentQuestionUidInModal;
		
		var sectionViewModel = {
		    sections: ko.observableArray(),
		    loaded: ko.observable(false),
		    unansweredMandatoryQuestions: ko.observable(false),
		    
		    niceTitle: function(title)
			{
		    	if (title.length < 80) {
		    		return title;
		    	}
		    	
		    	return "<span data-toggle='tooltip' data-html='true' title='" + title + "'>" + title.substring(0,75) + "...</span>";
			},
			
			niceAnswer: function(answer)
			{
		    	if (answer.length < 25) {
		    		return answer;
		    	}
		    	
		    	return "<span data-toggle='tooltip' title='" + answer + "'>" + answer.substring(0,20) + "...</span>";
			}
		};
		
		function loadSectionsAndQuestions() {
			var surveyid = ${form.survey.id};
			var uniquecode = "${uniqueCode}";
			var invitation = "${invitation}";
			var languagecode = "${form.language.code}";

			var data = "surveyid=" + surveyid + "&invitation=" + invitation + "&languagecode=" + languagecode + "&uniquecode=" + uniquecode;
			$.ajax({
				type: "GET",
				url: contextpath + "/runner/delphiStructure",
				data: data,
				beforeSend: function (xhr) {
					xhr.setRequestHeader(csrfheader, csrftoken);
				},
				error: function (data) {
					//TODO
					alert(data);
				},
				success: function (data, textStatus) {
					for (var i = 0; i < data.sections.length; i++) {
						sectionViewModel.sections.push(data.sections[i]);
					}
					
					for (var i = 0; i < data.sections.length; i++)
					{
						for (var j = 0; j < data.sections[i].questions.length; j++)
						{
							if (isDelphiShowAnswersAndStatisticsInstantly
								|| data.sections[i].questions[j].answer.length > 0)
							{
								var div = $('#delphiquestion' + data.sections[i].questions[j].uid);
								loadGraphDataInner(div, surveyid, data.sections[i].questions[j].uid, languagecode, uniquecode, addStructureChart, false);
							}
						}
					}

					sectionViewModel.loaded(true);
					sectionViewModel.unansweredMandatoryQuestions(data.unansweredMandatoryQuestions);
					$('[data-toggle="tooltip"]').tooltip()
				}
			 });
		}

		function loadDelphiModalStartPage(element) {
			var surveyid = ${form.survey.id};
			var uniquecode = "${uniqueCode}";
			var languagecode = "${form.language.code}";
			var uid = $(element).closest(".question").attr("data-uid");
			loadGraphDataInner(null, surveyid, uid, languagecode, uniquecode, addChartModalStartPage, false, true);
		}

		$(document).ready(function(){
			ko.applyBindings(sectionViewModel, $("#sections")[0]);
			ko.applyBindings(answersTableViewModel, $('.answers-table-modal').find('.modal-body')[0]);

			loadSectionsAndQuestions();
		});
	</script>
