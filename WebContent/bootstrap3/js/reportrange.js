$(document).ready(function() {
                  $('#reportrange').daterangepicker( 
                     {
                        ranges: {
                           'Today': [new Date(), new Date()],
                           'Tomorrow': [moment().add('days', 1), moment().add('days', 1)],
                           'Next 7 Days': [new Date(), moment().add('days', 6)],
                           'Next 30 Days': [new Date(), moment().add('days', 29)],
                           'This Month': [new Date(), moment().endOf('month')],
                           'Next Month': [moment().add('month', 1).startOf('month'), moment().add('month', 1).endOf('month')]
                        },
                        opens: 'left',
                        format: 'DD/MM/YYYY',
                        separator: ' to ',
                        startDate: new Date(),
                        endDate: moment().endOf('month'),
                        minDate: '01/01/2012',
                        maxDate: '12/31/2013',
                        locale: {
                            applyLabel: 'Submit',
                            fromLabel: 'From',
                            toLabel: 'To',
                            customRangeLabel: 'Custom Range',
                            daysOfWeek: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr','Sa'],
                            monthNames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                            firstDay: 1
                        },
                        showWeekNumbers: true,
                        buttonClasses: ['btn-default'],
                        dateLimit: false
                     },
                     function(start, end) {
                        $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
                     }
                  );
                  //Set the initial state of the picker label
                  $('#reportrange').val(moment().subtract('days', 0).format('DD/MM/YYYY') + ' - ' + moment().add('days', 29).format('DD/MM/YYYY'));

               });