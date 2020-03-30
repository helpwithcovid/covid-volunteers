const VolunteerGroups = {
  initialize() {
    $( document ).on('turbolinks:load', () => {
      $('#add_volunteers_to_group_button').click(function() {
        VolunteerGroups.addVolunteerToGroup(this);
      })

      $('#volunteer_list').on('click', '.volunteer-in-group', function() {
        VolunteerGroups.removeVolunteerFromGroup(this);
      })
    });
  },

  addVolunteerToGroup(that) {
    const projectId = $('#volunteer_group_project_id').val();
    const chosenUserIds = $('.volunteer-in-group .volunteer-group-user-id').map(function() { return $(this).val() }).toArray();

    $.post(`/admin/volunteer_groups/generate_volunteers?project_id=${projectId}`, { chosen_user_ids: chosenUserIds }, (data) => {
      const users = data.users;
      let html = '';

      for (const user of users) {
        const userRow = `
<li class="border-t border-gray-200 volunteer-in-group">
  <input type="hidden" value="${user.id}" name="volunteer_group[user_ids][]" class="volunteer-group-user-id" />
  <div class="block hover:bg-gray-50 focus:outline-none focus:bg-gray-50 transition duration-150 ease-in-out">
    <div class="px-4 py-4 sm:px-6">
      <div class="flex items-center justify-between">
        <div class="text-sm leading-5 font-medium text-indigo-600 truncate">
          ${user.name} / ${user.email}
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
    that.remove();
  },
};

export default VolunteerGroups
