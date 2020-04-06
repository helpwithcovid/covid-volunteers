const Project = {
  initialize() {
    $(document).on('turbolinks:load', () => {
      $('#volunteer_with_skills').click(function(ev) {
        Project.volunteerWithSkills(this, ev);
      });

      $('#volunteer_without_skills').click(function(ev) {
        Project.volunteerWithoutSkills(this, ev);
      });
    });
  },

  volunteerWithSkills(that, ev) {
    ev.preventDefault();
    ev.stopPropagation();

    const targetHref = $(that).attr('href');

    const headerHTML = "You're about to volunteer";
    const bodyHTML = `
Are you sure? The project owner will be alerted. Optionally you can also send them a note.

<div class="mt-3">
  <label for="volunteer_note" class="sr-only">Volunteer note</label>
  <div class="relative rounded-md shadow-sm">
    <input id="volunteer_note" class="form-input block w-full sm:text-sm sm:leading-5" placeholder="In one sentence, why are you interested?" />
  </div>
</div>
`;

    const callback = () => {
      const volunteerNote = $("#volunteer_note").val();
      $.post(targetHref, { volunteer_note: volunteerNote });
    }

    Covid.showModal(headerHTML, bodyHTML, [ { type: 'cancel' }, { type: 'submit', text: 'Volunteer', callback } ], 'warning');

    return false;
  },

  volunteerWithoutSkills(that, ev) {
    ev.preventDefault();
    ev.stopPropagation();

    const targetHref = $(that).attr('href');
    const skillsRequired = $(that).attr('x-skills-required');

    const headerHTML = "You're missing skills";
    const bodyHTML = `It looks like the skills needed for this project do not match your skillset. \n\nIf you think this is incorrect, please update your profile with one of the following skills: <b>${skillsRequired}</b>.`;

    const callback = () => window.location.href = targetHref;
    Covid.showModal(headerHTML, bodyHTML, [ { type: 'cancel' }, { type: 'submit', text: 'Edit Profile', callback } ], 'warning');

    return false;
  }
}

export default Project;