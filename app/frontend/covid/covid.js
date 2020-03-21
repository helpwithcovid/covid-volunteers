import Cookies from 'js-cookie'

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
  }
};
  
export default Covid
