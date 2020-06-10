
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
      window.location = '/office_hours/new';
    } else {
      OfficeHour.showVolunteerCard(that);
    }

    return false;
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
