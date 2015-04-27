HTMLWidgets.widget({

    name: "isotope",
    type: "output",

    initialize: function(el, width, height) {

        $(el).append('<div id="controls"></div>');
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


        ///// Selectize filters

        var $select = $("#select-car").selectize({
            options: [
            {id: 'avenger', make: 'dodge', model: 'Avenger'},
                // {id: 'caliber', make: 'dodge', model: 'Caliber'},
                // {id: 'caravan-grand-passenger', make: 'dodge', model: 'Caravan Grand Passenger'},
                {id: 'metal', make: 'tags', model: 'Metal'},
                {id: 'transition', make: 'tags', model: 'transition'},
                {id: 's8', make: 'audi', model: 'S8'},
                {id: 'tt', make: 'audi', model: 'TT'},
                {id: 'avalanche', make: 'chevrolet', model: 'Avalanche'},
                {id: 'aveo', make: 'chevrolet', model: 'Aveo'},
                {id: 'cobalt', make: 'chevrolet', model: 'Cobalt'},
                {id: 'silverado', make: 'chevrolet', model: 'Silverado'},
                {id: 'suburban', make: 'chevrolet', model: 'Suburban'},
                {id: 'tahoe', make: 'chevrolet', model: 'Tahoe'},
                {id: 'trail-blazer', make: 'chevrolet', model: 'TrailBlazer'},
            ],
            optgroups: [
                {id: 'tags', name: 'Tags'},
                {id: 'dodge', name: 'Dodge'},
                {id: 'audi', name: 'Audi'},
                {id: 'chevrolet', name: 'Chevrolet'}
            ],
            labelField: 'model',
            valueField: 'id',
            optgroupField: 'make',
            optgroupLabelField: 'name',
            optgroupValueField: 'id',
            optgroupOrder: ['chevrolet', 'dodge', 'audi'],
            searchField: ['model'],
            plugins: ['optgroup_columns']
            // ,
            // onChange: function(value) {
            //            console.log(value);
            //            var filterValues = filterItems(value);              
            //       }
        });

        var filterItems = function(value){
            // console.log(value.split(','));
            if(value == "") return("*")
            var v = value.split(',').map(function(a){return("."+a)});
            // console.log(a,v.join(""))
            // $container.isotope({ filter: filterValue });
            console.log(v.join(""))
            return(v.join(""))
        }


        $select.on('change', function() {
            // console.log(this)
            // console.log(this.selectize.getValue());
            var value = this.selectize.getValue()
            var filterValue = filterItems(value); 
            console.log("FILTER VALUE: "+ filterValue)
            console.log("typeOf: "+ typeof(filterValue))
            //$container.isotope({ filter: filterValue });
            instance.iso.arrange({
                filter: filterValue
            });
          });






    },
});
