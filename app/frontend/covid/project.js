const Project = {
  initialize() {
    $(document).on('turbolinks:load', () => {
      $('#volunteer_with_skills').click(function(ev) {
        Project.volunteerWithSkills(this, ev);
      });
    });
  },

  volunteerWithSkills(that, ev) {
    ev.preventDefault();
    ev.stopPropagation();

    const targetHref = $(that).attr('href');

    const headerHTML = "You're about to volunteer";
    const bodyHTML = 'Are you sure you want to volunteer? The project owner will be alerted.';

    const callback = () => $.post(targetHref);
    Covid.showModal(headerHTML, bodyHTML, [ { type: 'cancel' }, { type: 'submit', text: 'Volunteer', callback } ], 'warning');
    ev.preventDefault();
    return false;
  }
}

export default Project;