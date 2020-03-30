import Cookies from 'js-cookie'
import VolunteerGroups from './volunteer_groups'

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
  }
};

export default Covid
