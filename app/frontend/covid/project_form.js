const ProjectForm = {
  initialize() {
    $(document).on('turbolinks:load', () => {
      if ($('form.new_project,form.edit_project').length > 0) {
        $('input[name="project[accepting_volunteers]"]').on('click', function(e) {
          ProjectForm.updateState();
        });

        ProjectForm.updateState();
      }
    });
  },

  updateState() {
    if ($('input[name="project[accepting_volunteers]"]:checked').val() == 'true') {
      $('.is-accepting-volunteers').css('display', '');
      $('#project_looking_for').attr('required', 'required');
    }
    else {
      $('.is-accepting-volunteers').css('display', 'none');
      $('#project_looking_for').removeAttr('required');
    }
  }
}

export default ProjectForm;