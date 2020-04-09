import Cookies from 'js-cookie'
import VolunteerGroups from './volunteer_groups'
import Project from './project'
import ProjectForm from './project_form'

const Covid = {
  initialize() {
    $( document ).on('turbolinks:load', () => {
      $('#disable_funding_alert').click(() => {
        Cookies.set('funding_alert', false, { expires: 99999 })
        $('#disable_funding_container').remove();
      })

      $('#disable_highlight_projects_alert').click(() => {
        Cookies.set('highlight_projects_alert', false, { expires: 99999 })
        $('#disable_highlight_projects_container').remove();
      })
    });

    VolunteerGroups.initialize();
    ProjectForm.initialize();
    Project.initialize();
  },
  toggleFiltersOpen() {
    let filtersOpen;
    switch (Cookies.get('filters_open')) {
      default:
      case null:
      case undefined:
      case 'true':
        filtersOpen = true
        break;
      case false:
      case 'false':
        filtersOpen = false
        break;
    }
    Cookies.set('filters_open', !filtersOpen);
  },
  showModal(headerHTML, bodyHTML, actions, icon) {
    $(modal).attr('x-data', '{ open: false }');

    const modal = $('#modal')[0];
    $('#modal-header').html(headerHTML);
    $('#modal-body').html(bodyHTML);

    $('#modal-actions').html('');

    let idx = 0;
    for (const action of actions) {
      let actionHTML = '';
      if (action.type == 'cancel') {
        const text = action.text || 'Cancel';
        actionHTML = `
<span class="mt-3 flex w-full rounded-md shadow-sm sm:mt-0 sm:ml-3 sm:w-auto" id="modal_action_${idx}">
  <button @click="open = false;" type="button" class="inline-flex justify-center w-full rounded-md border border-gray-300 px-4 py-2 bg-white text-base leading-6 font-medium text-gray-700 shadow-sm hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline transition ease-in-out duration-150 sm:text-sm sm:leading-5">
    ${text}
  </button>
</span>
`;
      } else if (action.type == 'submit') {
        actionHTML = `
<span class="mt-3 flex w-full rounded-md shadow-sm sm:mt-0 sm:ml-3 sm:w-auto" id="modal_action_${idx}">
  <button type="button" class="inline-flex justify-center w-full rounded-md border border-gray-300 px-4 py-2 bg-indigo-600 text-base leading-6 font-medium text-white shadow-sm hover:bg-indigo-500 focus:outline-none focus:border-indigo-700 focus:shadow-outline-indigo transition ease-in-out duration-150 sm:text-sm sm:leading-5">
    ${action.text}
  </button>
</span>
`;
      }

      $('#modal-actions').prepend(actionHTML);

      if (action.callback) {
        $(`#modal_action_${idx} button`).click(() => action.callback());
      }

      idx += 1;
    }

    let iconHTML = '';
    if (icon == 'warning') {
      iconHTML = `
<svg class="h-6 w-6 text-orange-400" stroke="currentColor" fill="none" viewBox="0 0 24 24">
  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
</svg>`;
    }

    $('#modal-icon').html(iconHTML);

    $(modal).attr('x-data', '{ open: true }');
  }
};

export default Covid
