HTMLWidgets.widget({

    name: "isotope",
    type: "output",

    initialize: function(el, width, height) {

        $(el).append('<div id="controls"></div>');
        //$('#controls').append('<div id="filter"></div>')
        //$('#controls').append('<div id="sort"></div>')
        $(el).append('<div id="isotope-items"></div>');
        var iso = new Isotope('#isotope-items', {
            itemSelector: '.element-item',
            layoutMode: 'fitRows'
        });
        // console.log(iso.options.getSortData)
        return ({
            iso: iso
        })

    },

    resize: function(el, width, height, instance) {
        // instance.iso.bindResize();
    },

    renderValue: function(el, x, instance) {

        $("#controls").append(x.filterBtns);
        $("#controls").append(x.sortBtns);
        $("#isotope-items").append(x.items);

        var sortData = x.sortData;
        // var sortData = {
        //     name: '.name',
        //     url: '.url'
        // };
        console.log(sortData)

        // If sort: Initialize sort data
        // have to destroy iso and build it again
        instance.iso.destroy();
        instance.iso = new Isotope('#isotope-items', {
            itemSelector: '.element-item',
            layoutMode: 'fitRows',
            getSortData: sortData
        });



        // var elems = instance.iso.getItemElements()
        // console.log("PRE",elems)
        instance.iso.reloadItems();
        // var elems = instance.iso.getItemElements()
        // console.log("POST",elems)

        instance.iso.arrange();

        // // bind filter button click
        // $('#filters').on('click', 'button', function() {
        //     var filterValue = $(this).attr('data-filter');
        //     console.log(filterValue)
        //     instance.iso.arrange({
        //         filter: filterValue
        //     });
        // });

        // // bind filter button click
        // $('#filters').on('click', 'button', function() {
        //     var filterValue = $(this).attr('data-filter');
        //     console.log(filterValue)
        //     instance.iso.arrange({
        //         filter: filterValue
        //     });
        // });




        // // INITIALIZE DISCLOSURE MECHANISM
        // //

        // var Disclosure = function(el, options) {
        //     el.isActive = false;
        //     el.details = el.querySelectorAll('[data-details]');
        //     el.hide = function() {
        //         for (var i = 0; i < el.details.length; i++) {
        //             el.details[i].style.display = 'none';
        //         }
        //     };
        //     el.show = function() {
        //         for (var i = 0; i < el.details.length; i++) {
        //             el.details[i].style.display = 'block';
        //         }
        //     };
        //     el.toggle = function(e) {
        //         e.stopPropagation();
        //         el.isActive = !el.isActive;
        //         if (el.isActive) {
        //             el.show();
        //         } else {
        //             el.hide();
        //         }
        //     }
        //     el.addEventListener('click', function(e) {
        //         el.toggle(e);
        //     });
        //     el.hide();
        //     return el;
        // };

        // var disclosures = document.querySelectorAll('[data-disclosure]');

        // for (var i = 0; i < disclosures.length; i++) {
        //     disclosures[i] = new Disclosure(disclosures[i]);
        // }

        // //



        // bind filter button click
        $('#filters').on('click', 'a', function() {
            var filterValue = $(this).attr('data-filter');
            console.log(filterValue)
            instance.iso.arrange({
                filter: filterValue
            });
        });

        // bind sort button click
        $('#sorts').on('click', 'button', function() {
            var sortByValue = $(this).attr('data-sort-by');
            instance.iso.arrange({
                sortBy: sortByValue
            });
        });

        // change is-checked class on buttons
        $('.button-group').each(function(i, buttonGroup) {
            var $buttonGroup = $(buttonGroup);
            $buttonGroup.on('click', 'button', function() {
                $buttonGroup.find('.is-checked').removeClass('is-checked');
                $(this).addClass('is-checked');
            });
        });



    },
});
