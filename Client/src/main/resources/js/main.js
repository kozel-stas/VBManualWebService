;(function () {

    'use strict';


    // iPad and iPod detection
    var isiPad = function () {
        return (navigator.platform.indexOf("iPad") != -1);
    };

    var isiPhone = function () {
        return (
            (navigator.platform.indexOf("iPhone") != -1) ||
            (navigator.platform.indexOf("iPod") != -1)
        );
    };

    // Parallax
    var parallax = function () {
        $(window).stellar();
    };


    // Burger Menu
    var burgerMenu = function () {

        $('body').on('click', '.js-fh5co-nav-toggle', function (event) {

            event.preventDefault();

            if ($('#navbar').is(':visible')) {
                $(this).removeClass('active');
            } else {
                $(this).addClass('active');
            }


        });

    };


    var goToTop = function () {

        $('.js-gotop').on('click', function (event) {

            event.preventDefault();

            $('html, body').animate({
                scrollTop: $('html').offset().top
            }, 500);

            return false;
        });

    };


    // Page Nav
    var clickMenu = function () {

        $('#navbar a:not([class="external"])').click(function (event) {
            var section = $(this).data('nav-section'),
                navbar = $('#navbar');

            if ($('[data-section="' + section + '"]').length) {
                $('html, body').animate({
                    scrollTop: $('[data-section="' + section + '"]').offset().top
                }, 500);
            }

            if (navbar.is(':visible')) {
                navbar.removeClass('in');
                navbar.attr('aria-expanded', 'false');
                $('.js-fh5co-nav-toggle').removeClass('active');
            }

            event.preventDefault();
            return false;
        });


    };

    // Reflect scrolling in navigation
    var navActive = function (section) {

        var $el = $('#navbar > ul');
        $el.find('li').removeClass('active');
        $el.each(function () {
            $(this).find('a[data-nav-section="' + section + '"]').closest('li').addClass('active');
        });

    };

    var navigationSection = function () {

        var $section = $('section[data-section]');

        $section.waypoint(function (direction) {

            if (direction === 'down') {
                navActive($(this.element).data('section'));
            }
        }, {
            offset: '150px'
        });

        $section.waypoint(function (direction) {
            if (direction === 'up') {
                navActive($(this.element).data('section'));
            }
        }, {
            offset: function () {
                return -$(this.element).height() + 155;
            }
        });

    };


    // Window Scroll
    var windowScroll = function () {
        var lastScrollTop = 0;

        $(window).scroll(function (event) {

            var header = $('#fh5co-header'),
                scrlTop = $(this).scrollTop();

            if (scrlTop > 500 && scrlTop <= 2000) {
                header.addClass('navbar-fixed-top fh5co-animated slideInDown');
            } else if (scrlTop <= 500) {
                if (header.hasClass('navbar-fixed-top')) {
                    header.addClass('navbar-fixed-top fh5co-animated slideOutUp');
                    setTimeout(function () {
                        header.removeClass('navbar-fixed-top fh5co-animated slideInDown slideOutUp');
                    }, 100);
                }
            }

        });
    };


    // Animations

    var contentWayPoint = function () {
        var i = 0;
        $('.animate-box').waypoint(function (direction) {

            if (direction === 'down' && !$(this.element).hasClass('animated')) {

                i++;

                $(this.element).addClass('item-animate');
                setTimeout(function () {

                    $('body .animate-box.item-animate').each(function (k) {
                        var el = $(this);
                        setTimeout(function () {
                            el.addClass('fadeInUp animated');
                            el.removeClass('item-animate');
                        }, k * 200, 'easeInOutExpo');
                    });

                }, 100);

            }

        }, {offset: '85%'});
    };


    // Document on load.
    $(function () {

        // parallax();

        // burgerMenu();

        // clickMenu();

        // windowScroll();

        // navigationSection();

        // goToTop();


        // Animations
        contentWayPoint();


    });


}());

var switchDataProvider = function (dataProvider, firedByDom) {
    var switchPos = localStorage.getItem("data_provider");
    if (dataProvider) {
        switch (dataProvider) {
            case "RPC":
                localStorage.setItem("data_provider", "RPC");
                if (!firedByDom) {
                    change_period2("monthly", true);
                }
                registerDataProvider("RPC");
                break;
            case "REST":
                localStorage.setItem("data_provider", "REST");
                if (!firedByDom) {
                    change_period2("annuel", true);
                }
                registerDataProvider("REST");
                break;
            case "SOAP":
                localStorage.setItem("data_provider", "SOAP");
                if (!firedByDom) {
                    change_period2("semester", true);
                }
                registerDataProvider("SOAP");
                break;
        }
    } else {
        if (switchPos == "REST" || switchPos == "SOAP" || switchPos == "RPC") {
            switchDataProvider(switchPos, false);
        } else {
            switchDataProvider("REST", false);
        }
    }
};

switchDataProvider();

function change_period2(period, firedBySystem) {
    var monthly = document.getElementById("monthly2");
    var semester = document.getElementById("semester2");
    var annual = document.getElementById("annual2");
    var selector = document.getElementById("selector");
    if (period === "monthly") {
        selector.style.left = 0;
        selector.style.width = monthly.clientWidth + "px";
        selector.style.backgroundColor = "#777777";
        selector.innerHTML = "RPC";
        if (!firedBySystem) {
            switchDataProvider("RPC", true)
        }
    } else if (period === "semester") {
        selector.style.left = monthly.clientWidth + "px";
        selector.style.width = semester.clientWidth + "px";
        selector.innerHTML = "SOAP";
        selector.style.backgroundColor = "#418d92";
        if (!firedBySystem) {
            switchDataProvider("SOAP", true)
        }
    } else {
        selector.style.left = monthly.clientWidth + semester.clientWidth + 1 + "px";
        selector.style.width = annual.clientWidth + "px";
        selector.innerHTML = "REST";
        selector.style.backgroundColor = "#4d7ea9";
        if (!firedBySystem) {
            switchDataProvider("REST", true)
        }
    }
}