$(document).ready(function () {

    //sets up autocomplete
    $('#typeahead').typeahead({
        minLength: 3,
        items: 20,
        source: function (term, process) {
            var url = '/Events/Find';

            d = [];
            map = {};

            return $.getJSON(url, { term: term }, function (data) {
                $.each(data, function (i, event) {
                    map[event.Name] = event;
                    d.push(event.Name);
                });
                return process(d);
            });
        },
        updater: function (item) {
            $('#eventId').val(map[item].ID);
            return item;
        }
    });

    $('input[id=file]').change(function() {
        $('#excelFile').val($(this).val());
    });

});