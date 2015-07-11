HTMLWidgets.widget({

    name: "isotope",
    type: "output",

    initialize: function(el, width, height) {


        // $(el).append('<div id="isotopeControls"></div>');
        // $(el).append('<div id="isotope-items"></div>');
        

        // var iso = new Isotope('#isotope-items', {
        //     itemSelector: '.element-item'
        // });
        // // console.log(iso.options.getSortData)
        // return ({
        //     iso: iso
        // })
        return({})

    },

    resize: function(el, width, height, instance) {
        // instance.iso.bindResize();
        //instance.iso.reloadItems();
    },

    renderValue: function(el, x, instance) {

        $( "#isotopeControls" ).remove();
        $( "#isotope-items" ).remove();
        
        $(el).append('<div id="isotopeControls"></div>');
        $(el).append('<div id="isotope-items"></div>');
        var iso = new Isotope('#isotope-items', {
            itemSelector: '.element-item'
        });

        instance.iso = iso;


        var style = x.style;
        var style = "<style> body{overflow:auto !important;}" + style + "</style>" ;
        $(style).appendTo("body");

        $("#isotopeControls").append(x.filterBtns);
        $("#isotopeControls").append(x.sortBtns);
        $("#isotope-items").append(x.items);

        var layoutMode = x.layoutMode;

        var sortData = x.sortData;

        console.log(sortData)

        // If sort: Initialize sort data
        // have to destroy iso and build it again
        instance.iso.destroy();
        instance.iso = new Isotope('#isotope-items', {
            itemSelector: '.element-item',
            layoutMode: layoutMode,
            getSortData: sortData
        });



        // var elems = instance.iso.getItemElements()
        // console.log("PRE",elems)
        instance.iso.reloadItems();
        // var elems = instance.iso.getItemElements()
        // console.log("POST",elems)

// // layout Isotope again after all images have loaded
// imagesLoaded( el, function() {
//   instance.iso.layout();
// });

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

        var selOpts = {
            options: [
                {filterValueId: 'tables', groupId: 'tags', filterValueLabel: 'Tables'},
                {filterValueId: 'visualization', groupId: 'tags', filterValueLabel: 'Viz'},
                // {filterValueId: 'caravan-grand-passenger', groupId: 'dodge', filterValueLabel: 'Caravan Grand Passenger'},
                {filterValueId: 'metal', groupId: 'tags', filterValueLabel: 'Metal'},
                {filterValueId: 'transition', groupId: 'tags', filterValueLabel: 'transition'},
                {filterValueId: 'jpmarindiaz', groupId: 'author', filterValueLabel: 'jpmarindiaz'},
                {filterValueId: 'timelyportfolio', groupId: 'author', filterValueLabel: 'timelyportfolio'},
                {filterValueId: 'avalanche', groupId: 'chevrolet', filterValueLabel: 'Avalanche'},
                {filterValueId: 'aveo', groupId: 'chevrolet', filterValueLabel: 'Aveo'},
                {filterValueId: 'cobalt', groupId: 'chevrolet', filterValueLabel: 'Cobalt'},
                {filterValueId: 'silverado', groupId: 'chevrolet', filterValueLabel: 'Silverado'},
                {filterValueId: 'suburban', groupId: 'chevrolet', filterValueLabel: 'Suburban'},
                {filterValueId: 'tahoe', groupId: 'chevrolet', filterValueLabel: 'Tahoe'},
                {filterValueId: 'trail-blazer', groupId: 'chevrolet', filterValueLabel: 'TrailBlazer'},
            ],
            optgroups: [
                {groupId: 'tags', groupLabel: 'Tags'},
                {groupId: 'dodge', groupLabel: 'Dodge'},
                {groupId: 'author', groupLabel: 'Author'},
                {groupId: 'chevrolet', groupLabel: 'Chevrolet'}
            ],
            labelField: 'filterValueLabel',
            valueField: 'filterValueId',
            optgroupField: 'groupId',
            optgroupLabelField: 'groupLabel',
            optgroupValueField: 'groupId',
            // optgroupOrder: ['chevrolet', 'dodge', 'audi'],
            searchField: ['filterValueLabel'],
            plugins: ['optgroup_columns','remove_button']
        };



        var selectizeOpts = HTMLWidgets.dataframeToD3(x.selectizeOptions);
        var selectizeOptgroups = HTMLWidgets.dataframeToD3(x.selectizeOptgroups);
        selOpts.options = selectizeOpts;
        selOpts.optgroups = selectizeOptgroups;

        var $select = $("#select-car").selectize(selOpts);

        var filterItems = function(value){
            if(value == "") return("*")
            var v = value.split(',').map(function(a){return("."+a)});
            console.log(v.join(""))
            return(v.join(""))
        }


        $select.on('change', function() {
            var value = this.selectize.getValue()
            var filterValue = filterItems(value); 
            console.log("FILTER VALUE: "+ filterValue)
            console.log("typeOf: "+ typeof(filterValue))
            instance.iso.arrange({
                filter: filterValue
            });
          });

        instance.iso.bindResize();




    },
});
