const OfficeHour = {
  initialize() {
    $(document).on('turbolinks:load', () => {
      $('body').on('click', '.oh-action', function (e) {
        OfficeHour.showCardAction(e, this);
      });
    }).on('turbolinks:before-cache', function () {
    });
  },

  showCardAction(e, that) {
    e.preventDefault();

    const isOwner = $(that).attr('x-is-owner');

    if (isOwner == 'true') {
      OfficeHour.showOwnerCard(that);
    } else {
      OfficeHour.showVolunteerCard(that);
    }

    return false;
  },

  showOwnerCard(that) {
    const participant = JSON.parse($(that).attr('x-participant'));

    if (participant && participant.name) {
      OfficeHour.showOwneParticipantCard(that);
    } else {
      OfficeHour.showOwnerVolunteerCard(that);
    }
  },

  showOwneParticipantCard(that) {
    const OHId = $(that).attr('x-id');
    const when = $(that).attr('x-when');
    const participant = JSON.parse($(that).attr('x-participant'));

    const headerHTML = `${when} Office Hour`;
    const bodyHTML = `
      <br/>You have accepted:<br/><span class='text-indigo-600'>${participant.name}</span> / <span class='text-indigo-600'>${participant.email}</span>
      `;

    Covid.showModal(headerHTML, bodyHTML, [ { type: 'cancel', text: 'Close' } ], 'warning');
  },

  showOwnerVolunteerCard(that) {
    const OHId = $(that).attr('x-id');
    const when = $(that).attr('x-when');
    const volunteers = JSON.parse($(that).attr('x-volunteers'));

    const modalActions =  [ { type: 'danger', text: 'Delete slot', deleteCallback }, { type: 'cancel' } ];
    let volunteerHTML = '';

    if (volunteers.length > 0) {
      volunteerHTML += "Below are the people that applied for this slot:<br/>";

      for (const volunteer of volunteers) {
        let projectsHTML = '';
        for (const project of volunteer.projects) {
          projectsHTML += `
            <div class="sm:flex sm:justify-between">
              <div class="ml-7 flex items-center text-sm leading-5 text-gray-500">
                -&nbsp;&nbsp;<a href="/projects/${project.id}" target="_blank" class="hover:underline">${project.name}</a>
              </div>
            </div>`;
        }

        volunteerHTML += `
          <ul class="mt-2">
            <li>
              <div class="mb-2">
                <div class="flex items-center justify-between">
                  <div class="text-sm leading-5 font-medium text-indigo-600 truncate">
                    <input name="applicant_id" value="${volunteer.id}" type="radio" class="form-radio inline-block mr-2 h-4 w-4 text-indigo-600 transition duration-150 ease-in-out" />
                    <a href="/users/${volunteer.id}" target="_blank" class="hover:underline">
                      ${volunteer.name}
                    </a>
                  </div>
                </div>
                ${projectsHTML}
              </div>
            </li>
          </ul>

          <div class="mt-2">
            Once you accept someone you'll both receive a call invite.
          </div>
        `;
      }

      modalActions.push( { type: 'submit', text: 'Accept', callback: acceptCallback });
    } else {
      volunteerHTML = 'Nobody has applied yet.';
    }

    const headerHTML = `${when} Office Hour`;
    const bodyHTML = `
      You have a slot at <span class="text-indigo-600">${when}</span>.
      <br>
      <br>
      ${volunteerHTML}
      `;

      const acceptCallback = () => {
        const acceptedUserId = $('input[name="applicant_id"]:checked').val();

        if (!acceptedUserId) {
          alert("Please choose an applicant.");
          return;
        }

        $.ajax({
          url: `/office_hours/${OHId}/accept?accepted_user_id=${acceptedUserId}`,
          type: 'POST',
        });
      }

    const deleteCallback = () => {
      $.ajax({
        url: `/office_hours/${OHId}`,
        type: 'DELETE',
      });
    }

    Covid.showModal(headerHTML, bodyHTML, modalActions, 'warning');
  },

  showVolunteerCard(that) {
    const OHId = $(that).attr('x-id');
    const OHOwner = $(that).attr('x-oh-owner');
    const OHInactive = $(that).attr('x-oh-inactive');
    const when = $(that).attr('x-when');
    const canApply = $(that).attr('x-can-apply');

    if (OHInactive == 'true') {
      return;
    }

    if (canApply == 'true') {
      const headerHTML = `${when} Office Hour`;
      const bodyHTML = `
        There is a slot available <span class="text-indigo-600">${when}</span>.
        <br/>
        <br/>
        You can apply below. You'll receive an email if you were accepted.
        <br/><br/>
        Make sure your volunteer bio is filled out! We'll send that and your projects to <span class="text-indigo-600">${OHOwner}</span>.
        `;

      const callback = () => {
        $.ajax({
          url: `/office_hours/${OHId}/apply`,
          type: 'POST',
        });
      }

      Covid.showModal(headerHTML, bodyHTML, [ { type: 'cancel' }, { type: 'submit', text: 'Apply', callback } ], 'warning');
    } else {
      const headerHTML = `${when} Office Hour`;
      const bodyHTML = `
        There is a slot available <span class="text-indigo-600">${when}</span>.
        <br/>
        <br/>
        In order to apply you must have an account and your profiled filled out.
        `;

      Covid.showModal(headerHTML, bodyHTML, [ { type: 'cancel', text: 'Close' } ], 'warning');
    }
  }

}

export default OfficeHour;
