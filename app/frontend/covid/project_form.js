const ProjectForm = {
  initialize() {
    $(document).on('turbolinks:load', () => {
      if ($('form.new_project,form.edit_project').length > 0) {
        $('input[name="project[accepting_volunteers]"]').on('click', function(e) {
          ProjectForm.updateState();
        });

        $('input[name="project[accepting_volunteers]"]').on('click', function(e) {
          ProjectForm.updateState();
        });

        $('#project_organization_status').on('change', function(e) {
          ProjectForm.updateState();
        });

        ProjectForm.updateState();
      }
    });
  },

  updateState() {
    if ($('input[name="project[accepting_volunteers]"]:checked').val() == 'true') {
      $('.is-accepting-volunteers').show();
      $('#project_looking_for').attr('required', 'required');
    }
    else {
      $('.is-accepting-volunteers').hide();
      $('#project_looking_for').removeAttr('required');
    }

    if ($('#project_organization_status').val() == 'Non-profit') {
      $('.is-non-profit').show();
      $('#project_ein').attr('required', 'required');
    } else {
      $('.is-non-profit').hide();
      $('#project_ein').removeAttr('required');
    }

    if ($('#project_organization_status').val() == 'For-profit') {
      $('.for-profit-warning').show();
    } else {
      $('.for-profit-warning').hide();
    }
  }
}

export default ProjectForm;
