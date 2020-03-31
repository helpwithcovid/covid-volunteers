const VolunteerGroups = {
  initialize() {
    $( document ).on('turbolinks:load', () => {
      $('#add_volunteers_to_group_button').click(function() {
        VolunteerGroups.addVolunteerToGroup(this);
      })

      $('#volunteers_group_intro_email_button').click(function() {
        VolunteerGroups.prepareIntroEmail(this);
      })

      $('#volunteer_list').on('click', '.volunteer-in-group', function() {
        VolunteerGroups.removeVolunteerFromGroup(this);
      })
    });
  },

  addVolunteerToGroup(that) {
    const projectId = $('#project_id').val();
    const currentRejectedUserIds = $('#rejected_user_ids').val().split(',').filter(el => el);
    const chosenUserIds = $('.volunteer-in-group .volunteer-group-user-id').map(function() { return $(this).val() }).toArray();

    $.post(`/admin/volunteer_groups/generate_volunteers?project_id=${projectId}`, { user_ids: chosenUserIds, rejected_user_ids: currentRejectedUserIds }, (data) => {
      const users = data.users;
      let html = '';

      if (data.users.length == 0) {
        alert("Sorry, couldn't find any matching volunteers.");
        return;
      }

      for (const user of users) {
        const userRow = `
<li class="border-t border-gray-200 volunteer-in-group">
  <input type="hidden" value="${user.id}" name="volunteer_group[user_ids][]" class="volunteer-group-user-id" />
  <div class="block hover:bg-gray-50 focus:outline-none focus:bg-gray-50 transition duration-150 ease-in-out">
    <div class="px-4 py-4 sm:px-6">
      <div class="flex items-center justify-between">
        <div class="text-sm leading-5 font-medium text-indigo-600 truncate">
          <span class="volunteer-name">${user.name}</span> / <span class="volunteer-email">${user.email}</span>
        </div>
        <div class="text-sm leading-5 truncate">
          <a href="javascript:void(0)">
            <span class="inline-flex rounded-md shadow-sm">
              <button type="button" class="inline-flex items-center px-2.5 py-1.5 border border-gray-300 text-xs leading-4 font-medium rounded text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
                <svg class="-ml-1 mr-2 h-4 w-4 text-gray-700" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd"/>
                </svg>
                <span>
                  remove
                </span>
              </button>
            </span>
          </a>
        </div>
      </div>
      <div class="mt-3 sm:flex sm:justify-between">
        <div class="text-sm leading-5 text-gray-500">
          ${user.about}
        </div>
      </div>
      <div class="mt-2 sm:flex sm:justify-between">
        <div class="text-sm leading-5 text-gray-500">
          location: ${user.location} / skills: ${user.skill_list ? user.skill_list.join(', '): ''}
        </div>
      </div>
    </div>
  </div>
</li>`;
        html += userRow;
      }

      $('#no_volunteer_list').hide();
      $('#volunteer_list').append(html);
    });
  },

  removeVolunteerFromGroup(that) {
    const rejectedUserId = $(that).find('.volunteer-group-user-id').val();
    const currentRejectedUserIds = $('#rejected_user_ids').val();
    $('#rejected_user_ids').val(`${currentRejectedUserIds},${rejectedUserId}`);
    that.remove();
  },

  prepareIntroEmail(that) {
    const projectId = $('#project_id').val();
    const projectOwnerEmail = $('#project_owner_email').val();
    const projectName = $('#project_name').val();
    const volunteers = [];
    const volunteerEmails = [];

    $('.volunteer-in-group').each((_, el) => {
      const email = $(el).find('.volunteer-email').text();
      const name = $(el).find('.volunteer-name').text();
      volunteers.push({ email, name });
      volunteerEmails.push(email);
    });

    const subject = `[Help With Covid] Greetings - Project/Volunteers Introduction`;

    let volunteersBody = [];
    for (const volunteer of volunteers) {
      volunteersBody.push(`${volunteer.name} / ${volunteer.email}`);
    }

    let body = `Hi there!

Hope you are all doing well! Thank you for all that you are doing to work on a solution for our world and being part of helpwithcovid.com.

This project needs your help: ${projectName} (http://helpwithcovid.com/projects/${projectId}) by ${projectOwnerEmail}. I thought you might be able to help. I have included the project owner to this email should have any questions.

Please let me know if you have any questions or concerns.

Thank you!
HWC Core team
`;

    const mailHref=`mailto:${projectOwnerEmail}?bcc=${volunteerEmails.join(',').replace(/\+/g, '%2B')}&subject=${subject}&body=${body.replace(/\n/g, '%0D%0A').replace(/\+/g, '%2B')}`;
    window.open(mailHref, '_blank');
  },
};

export default VolunteerGroups
