import flatpickr from 'flatpickr';

const dateOpts = {
  altInput: true,
  altFormat: 'F j, Y',
  dateFormat: 'Y-m-d',
  minDate: new Date(),
};

const timeOpts = {
  enableTime: true,
  noCalendar: true,
  dateFormat: "H:i",
  defaultHour: 10,
  defaultMinute: 0,
  minuteIncrement: 10,
}

const OfficeHourForm = {
  initialize() {
    $(document).on('turbolinks:load', () => {
      if ($('.office-hour-form').length > 0) {

        $('body').on('click', '.add-office-hour-slot', function (e) {
          OfficeHourForm.addOfficeHourSlot(e);
        });

        $('body').on('click', '.remove-office-hour-slot', function (e) {
          OfficeHourForm.removeOfficeHourSlot(e, this);
        });


        $('body').on('click', '.create-office-hour-slots', function (e) {
          OfficeHourForm.createOfficeHourSlots(e);
        });

        OfficeHourForm.setupFlatpickr();
      }

    }).on('turbolinks:before-cache', function () {
      if ($('.office-hour-form').length > 0) {
        OfficeHourForm.removeFlatpickr();
      }
    });
  },

  addOfficeHourSlot(e) {
    e.preventDefault();

    OfficeHourForm.removeFlatpickr();

    const slotForm = $('.office-hour-form-template').first().clone();

    $(slotForm).find('.office-hour-date').val('');
    $(slotForm).find('.office-hour-time').val('');
    $(slotForm).find('.office-hour-slot-errors').text('');
    $(slotForm).find('.add-office-hour-slot').addClass('hidden');
    $(slotForm).find('.remove-office-hour-slot').removeClass('hidden');

    $(slotForm).addClass('mt-6');
    $('.office-hour-form').append(slotForm);

    OfficeHourForm.setupFlatpickr();

    return false;
  },

  removeOfficeHourSlot(e, that) {
    $(that).parents('.office-hour-form-template').remove();
  },

  removeFlatpickr() {
    $('.office-hour-date').each(function() {
      const parent = $(this).parent();
      const date = $(this).val();
      flatpickr(this).destroy();
      $(parent).find('.office-hour-date').val(date);
    });

    $('.office-hour-time').each(function() {
      const parent = $(this).parent();
      const time = $(this).val();
      flatpickr(this).destroy();
      $(parent).find('.office-hour-time').val(time);
    });
  },

  setupFlatpickr() {
    $('.office-hour-date').each(function() {
      const date = $(this).val();
      const dateObj = flatpickr(this, dateOpts);
      dateObj.setDate(date, dateOpts.dateFormat);
    });

    $('.office-hour-time').each(function() {
      const time = $(this).val();
      const timeObj = flatpickr(this, timeOpts);
      timeObj.setDate(time, timeOpts.dateFormat);
    });
  },

  createOfficeHourSlots(e) {
    e.preventDefault();

    $('.office-hour-slot-errors').text('');

    const slots = $('.office-hour-form-template');
    const dates = [];

    for (const slot of slots) {
      const date = $(slot).find('.office-hour-date').val();
      const time = $(slot).find('.office-hour-time').val();
      const length = $(slot).find('.office-hour-length').val();

      if (!date || !time || !length) {
        $(slot).find('.office-hour-slot-errors').text('Please enter a date and a time.');
        continue;
      }

      const parsedStartDate = flatpickr.parseDate(`${date} ${time}`, `${dateOpts.dateFormat} ${timeOpts.dateFormat}`);

      dates.push(parsedStartDate);
      let parsedEndDate = null;

      if (length == '10m') {
        parsedEndDate = new Date(parsedStartDate.getTime() + 10 * 60000);
      } else if (length == '20m') {
        parsedEndDate = new Date(parsedStartDate.getTime() + 20 * 60000);
      } else if (length == '30m') {
        parsedEndDate = new Date(parsedStartDate.getTime() + 30 * 60000);
      }
      dates.push(parsedEndDate);
    }

    if (OfficeHourForm.doDatesOverlap(dates)) {
      $('.office-hour-slot-errors').first().text("We're sorry, it seems like the dates overlap.");
      return false;
    }

    $.post('/office_hours', { office_hour_dates: dates });
    return false;
  },

  doDatesOverlap(dates) {
    if (dates.length % 2 !== 0) {
      return true;
    }

    for (let i = 0; i < dates.length - 2; i += 2) {
      for (let j = i + 2; j < dates.length; j += 2) {
        if (OfficeHourForm.dateRangeOverlaps(dates[i], dates[i+1], dates[j], dates[j+1])) {
          return true;
        }
      }
    }
    return false;
  },

  dateRangeOverlaps(a_start, a_end, b_start, b_end) {
    if (a_start <= b_start && b_start <= a_end) return true; // b starts in a
    if (a_start <= b_end   && b_end   <= a_end) return true; // b ends in a
    if (b_start <  a_start && a_end   <  b_end) return true; // a in b
    return false;
  },

}

export default OfficeHourForm;
