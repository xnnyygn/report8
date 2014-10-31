# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
	$('.btn-modify').click ->
		sentence_block = $(this).parents('.sentence')

		# hide advice block
		sentence_block.find('.sentence-advice').hide()

		# show edit pane
		sentence_block.find('.edit-pane').show()

		# hide modified button
		$(this).hide()

	$('.btn-cancel').click ->
		sentence_block = $(this).parents('.sentence')

		# hide edit pane
		sentence_block.find('.edit-pane').hide()

		# show advice
		# recover sentence editor content
		editor_id = sentence_block.find('.sentence-editor').attr('id')
		latest_correction = sentence_block.find('.sentence-correction').html()
		if sentence_block.find('.sentence-modified').val() == 'true'
			tinyMCE.get(editor_id).setContent(latest_correction)
			sentence_block.find('.sentence-advice').show()
		else
			sentence_original = sentence_block.find('.sentence-original').text()
			tinyMCE.get(editor_id).setContent(sentence_original)
		# recover comment
		sentence_comment = sentence_block.find('.sentence-comment').text()
		sentence_block.find('.sentence-comment-edit').val(sentence_comment)

		# show modified button
		sentence_block.find('.btn-modify').show()

	$('.btn-save').click ->
		sentence_block = $(this).parents('.sentence')

		# hide edit pane
		sentence_block.find('.edit-pane').hide()

		# show advice
		editor_id = sentence_block.find('.sentence-editor').attr('id')
		content = tinyMCE.get(editor_id).getContent()
		# copy sentence editor content
		sentence_block.find('.sentence-correction').html(content)
		# copy sentence comment content
		sentence_comment = sentence_block.find('.sentence-comment-edit').val()
		sentence_block.find('.sentence-comment').html(sentence_comment)
		# set modified status
		sentence_block.find('.sentence-modified').val('true')
		sentence_block.find('.sentence-advice').show()

		# show button
		sentence_block.find('.btn-modify').show()

		# enable submit corrections button
		$('#btn-submit-corrections').removeAttr('disabled')

	$('.btn-remove').click ->
		if confirm('Do you really want to delete this correction?')
			remove_correction($(this).parents('.sentence'))

			# determine submit button status
			# first disable button
			$('#btn-submit-corrections').attr('disabled', 'disabled')
			$('.sentence-modified').each ->
				if $(this).val() == 'true'
					$('#btn-submit-corrections').removeAttr('disabled')
					# stop loop
					return false

	# initialize editors
	tinymce.init
    selector: ".sentence-editor",
    theme: 'advanced',
    theme_advanced_resizing : true,
    theme_advanced_buttons1: 'undo,redo,|,strikethrough,forecolor,|,removeformat',
    theme_advanced_text_colors : 'FF0000,0000FF,000000',
    theme_advanced_default_foreground_color : '#FF0000',
    theme_advanced_more_colors : false,
    width: '100%',
    content_css: '/assets/sentence-editor.css'

  $('#btn-reset-corrections').click ->
  	if confirm('Do you really want to delete all corrections?')
  		$('.sentence').each ->
  			remove_correction($(this))

  		# disable submit
  		$('#btn-submit-corrections').attr('disabled', 'disabled');

remove_correction = (sentence_block) ->
	# hide sentence-advice
	sentence_block.find('.sentence-advice').hide()

	# clear modified sentence
	sentence_block.find('.sentence-correction').html('')

	# reset editor content
	editor_id = sentence_block.find('.sentence-editor').attr('id')
	sentence_original = sentence_block.find('.sentence-original').text()
	tinyMCE.get(editor_id).setContent(sentence_original)
	# reset comment
	sentence_block.find('.sentence-comment-edit').val('')
	sentence_block.find('.sentence-comment').html('')
	# reset status
	sentence_block.find('.sentence-modified').val('false')

$(document).ready(ready)
$(document).on('page:load', ready)