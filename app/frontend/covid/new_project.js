const NewProject = {
    initialize() {
      $( document ).on('turbolinks:load', () => {
        if ($('form.new_project,form.edit_project').length > 0) {
            $('#project_accepting_volunteers').on('click', function(e){
                NewProject.updateState();
            });

            NewProject.updateState();
        }
      });
    },

    updateState() {
        if ($('#project_accepting_volunteers').is(':checked')) {
            console.log($('.is-accepting-volunteers'));
            $('.is-accepting-volunteers').css('display', '');
            $('#project_looking_for').attr('required', 'required');
        }
        else {
            $('.is-accepting-volunteers').css('display', 'none');
            $('#project_looking_for').removeAttr('required');
        }
    }
}

export default NewProject;