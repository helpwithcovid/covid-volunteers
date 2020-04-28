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
        VolunteerGroups.toggleKeepInGroup(this);
      })
    });
  },

  addVolunteerToGroup(that) {
    const projectId = $('#project_id').val();
    const currentAcceptedUserIds = $('#accepted_user_ids').val().split(',').filter(el => el);

    $('.volunteer-in-group').each((_, el) => {
      const userId = $(el).find('.volunteer-group-user-id').val();

      if (currentAcceptedUserIds.indexOf(userId) == -1) {
        $(el).remove();
      }
    });

    const filter = $('#filter_volunteers').val();

    $.post(`/admin/volunteer_groups/generate_volunteers?project_id=${projectId}`, { user_ids: currentAcceptedUserIds, filter }, (data) => {
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
  <div class="block focus:outline-none transition duration-150 ease-in-out">
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
                  <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                </svg>
                <span>
                  keep
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

  toggleKeepInGroup(that) {
    const acceptedUserId = $(that).find('.volunteer-group-user-id').val();
    let acceptedUserIds = $('#accepted_user_ids').val().split(',');

    if (acceptedUserIds.indexOf(acceptedUserId) > -1) {
      $(that).removeClass('border-orange-300 bg-orange-100');
      acceptedUserIds = acceptedUserIds.filter(val => val != acceptedUserId);
    } else {
      $(that).addClass('border-orange-300 bg-orange-100');
      acceptedUserIds.push(acceptedUserId);
    }

    $('#accepted_user_ids').val(acceptedUserIds.join(','));
  },

  prepareIntroEmail(that) {
    const currentAcceptedUserIds = $('#accepted_user_ids').val().split(',').filter(el => el);
    const projectId = $('#project_id').val();
    const projectOwnerEmail = $('#project_owner_email').val();
    const projectName = encodeURIComponent($('#project_name').val());
    const volunteers = [];
    const volunteerEmails = [];

    $('.volunteer-in-group').each((_, el) => {
      const userId = $(el).find('.volunteer-group-user-id').val();
      const email = $(el).find('.volunteer-email').text();
      const name = $(el).find('.volunteer-name').text();

      if (currentAcceptedUserIds.indexOf(userId) > -1) {
        volunteers.push({ email, name });
        volunteerEmails.push(email);
      }
    });

    const subject = `[Help With Covid] Greetings - Project/Volunteers Introduction`;

    let volunteersBody = [];
    for (const volunteer of volunteers) {
      volunteersBody.push(`${volunteer.name} / ${volunteer.email}`);
    }

    let body = `Hi there!

Hope you are all doing well! Thank you for all that you are doing to work on a solution for our world and being part of helpwithcovid.com.

This project needs your help: ${projectName} (http://helpwithcovid.com/projects/${projectId}) by project owner - ${projectOwnerEmail}. I thought you might be able to help. I have included the project owner to this email should you have any questions.

If you are already on an existing project, please login to helpwithcovid.com and remove the setting "pair me with a project" from your profile page (https://helpwithcovid.com/users/edit).

If you feel that you are not the right fit after speaking with the project owner, please go to the project link (http://helpwithcovid.com/projects/${projectId}) and “cancel volunteer offer”. We will work on matching you to another project.

Please let me know if you have any questions or concerns.

Thank you!
HWC Core team`;

    const mailHref=`mailto:${projectOwnerEmail}?reply-to=${projectOwnerEmail}&bcc=${volunteerEmails.join(',').replace(/\+/g, '%2B')}&subject=${subject}&body=${body.replace(/\n/g, '%0D%0A').replace(/\+/g, '%2B')}`;
    window.open(mailHref, '_blank');
  },
};

export default VolunteerGroups
