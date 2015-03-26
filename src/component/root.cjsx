_       = require 'underscore'
React   = require 'react'

Root = React.createClass {
    getDefaultProps: ->
        {
            restaurants: []
        }
    render: ->
        <div>
            <nav className="navbar" role="navigation">
                <div className="container">
                    <div className="navbar-header">
                        <button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#top-navbar-1">
                            <span className="sr-only">Toggle navigation</span>
                            <span className="icon-bar"></span>
                            <span className="icon-bar"></span>
                            <span className="icon-bar"></span>
                        </button>
                        <a className="navbar-brand" href="index.html">Andia - a super cool design agency...</a>
                    </div>
                    <div className="collapse navbar-collapse" id="top-navbar-1">
                        <ul className="nav navbar-nav navbar-right">
                            <li className="dropdown active">
                                <a href="#" className="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000">
                                    <i className="fa fa-home"></i><br/>Home <span className="caret"></span>
                                </a>
                                <ul className="dropdown-menu dropdown-menu-left" role="menu">
                                    <li className="active"><a href="index.html">Home</a></li>
                                    <li><a href="index-2.html">Home 2</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="portfolio.html"><i className="fa fa-camera"></i><br/>Portfolio</a>
                            </li>
                            <li>
                                <a href="#"><i className="fa fa-comments"></i><br/>Blog</a>
                            </li>
                            <li>
                                <a href="services.html"><i className="fa fa-tasks"></i><br/>Services</a>
                            </li>
                            <li>
                                <a href="about.html"><i className="fa fa-user"></i><br/>About</a>
                            </li>
                            <li>
                                <a href="contact.html"><i className="fa fa-envelope"></i><br/>Contact</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div className="slider-container">
                <div className="container">
                    <div className="row">
                        <div className="col-sm-10 col-sm-offset-1 slider">
                            <div className="flexslider">
                                <ul className="slides">
                                    <li data-thumb="assets/img/slider/1.jpg">
                                        <img src="assets/img/slider/1.jpg"/>
                                        <div className="flex-caption">
                                            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et. 
                                            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et. 
                                            Lorem ipsum dolor sit amet, consectetur.
                                        </div>
                                    </li>
                                    <li data-thumb="assets/img/slider/2.jpg">
                                        <img src="assets/img/slider/2.jpg"/>
                                        <div className="flex-caption">
                                            Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit 
                                            lobortis nisl ut aliquip ex ea commodo consequat.
                                        </div>
                                    </li>
                                    <li data-thumb="assets/img/slider/3.jpg">
                                        <img src="assets/img/slider/3.jpg" />
                                        <div className="flex-caption">
                                            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et. 
                                            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et. 
                                            Lorem ipsum dolor sit amet, consectetur.
                                        </div>
                                    </li>
                                    <li data-thumb="assets/img/slider/4.jpg">
                                        <img src="assets/img/slider/4.jpg"/>
                                        <div className="flex-caption">
                                            Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit 
                                            lobortis nisl ut aliquip ex ea commodo consequat.
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div className="presentation-container">
                <div className="container">
                    <div className="row">
                        <div className="col-sm-12 wow fadeInLeftBig">
                            <h1>We are <span className="violet">Andia</span>, a super cool design agency.</h1>
                            <p>We design beautiful websites, logos and prints. Your project is safe with us.</p>
                        </div>
                    </div>
                </div>
            </div>

            <div className="services-container">
                <div className="container">
                    <div className="row">
                        <div className="col-sm-3">
                            <div className="service wow fadeInUp">
                                <div className="service-icon"><i className="fa fa-eye"></i></div>
                                <h3>Beautiful Websites</h3>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et...</p>
                                <a className="big-link-1" href="services.html">Read more</a>
                            </div>
                        </div>
                        <div className="col-sm-3">
                            <div className="service wow fadeInDown">
                                <div className="service-icon"><i className="fa fa-table"></i></div>
                                <h3>Responsive Layout</h3>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et...</p>
                                <a className="big-link-1" href="services.html">Read more</a>
                            </div>
                        </div>
                        <div className="col-sm-3">
                            <div className="service wow fadeInUp">
                                <div className="service-icon"><i className="fa fa-magic"></i></div>
                                <h3>Awesome Logos</h3>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et...</p>
                                <a className="big-link-1" href="services.html">Read more</a>
                            </div>
                        </div>
                        <div className="col-sm-3">
                            <div className="service wow fadeInDown">
                                <div className="service-icon"><i className="fa fa-print"></i></div>
                                <h3>High Res Prints</h3>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et...</p>
                                <a className="big-link-1" href="services.html">Read more</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div className="work-container">
                <div className="container">
                    <div className="row">
                        <div className="col-sm-12 work-title wow fadeIn">
                            <h2>Our Latest Work</h2>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-3">
                            <div className="work wow fadeInUp">
                                <img src="assets/img/portfolio/work1.jpg" alt="Lorem Website" data-at2x="assets/img/portfolio/work1.jpg"/>
                                <h3>Lorem Website</h3>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor...</p>
                                <div className="work-bottom">
                                    <a className="big-link-2 view-work" href="assets/img/portfolio/work1.jpg"><i className="fa fa-search"></i></a>
                                    <a className="big-link-2" href="portfolio.html"><i className="fa fa-link"></i></a>
                                </div>
                            </div>
                        </div>
                        <div className="col-sm-3">
                            <div className="work wow fadeInDown">
                                <img src="assets/img/portfolio/work2.jpg" alt="Ipsum Logo" data-at2x="assets/img/portfolio/work2.jpg"/>
                                <h3>Ipsum Logo</h3>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor...</p>
                                <div className="work-bottom">
                                    <a className="big-link-2 view-work" href="assets/img/portfolio/work2.jpg"><i className="fa fa-search"></i></a>
                                    <a className="big-link-2" href="portfolio.html"><i className="fa fa-link"></i></a>
                                </div>
                            </div>
                        </div>
                        <div className="col-sm-3">
                            <div className="work wow fadeInUp">
                                <img src="assets/img/portfolio/work3.jpg" alt="Dolor Prints" data-at2x="assets/img/portfolio/work3.jpg"/>
                                <h3>Dolor Prints</h3>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor...</p>
                                <div className="work-bottom">
                                    <a className="big-link-2 view-work" href="assets/img/portfolio/work3.jpg"><i className="fa fa-search"></i></a>
                                    <a className="big-link-2" href="portfolio.html"><i className="fa fa-link"></i></a>
                                </div>
                            </div>
                        </div>
                        <div className="col-sm-3">
                            <div className="work wow fadeInDown">
                                <img src="assets/img/portfolio/work4.jpg" alt="Sit Amet Website" data-at2x="assets/img/portfolio/work4.jpg"/>
                                <h3>Sit Amet Website</h3>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor...</p>
                                <div className="work-bottom">
                                    <a className="big-link-2 view-work" href="assets/img/portfolio/work4.jpg"><i className="fa fa-search"></i></a>
                                    <a className="big-link-2" href="portfolio.html"><i className="fa fa-link"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div className="testimonials-container">
                <div className="container">
                    <div className="row">
                        <div className="col-sm-12 testimonials-title wow fadeIn">
                            <h2>Testimonials</h2>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-10 col-sm-offset-1 testimonial-list">
                            <div role="tabpanel">
                                <div className="tab-content">
                                    <div role="tabpanel" className="tab-pane fade in active" id="tab1">
                                        <div className="testimonial-image">
                                            <img src="assets/img/testimonials/1.jpg" alt="" data-at2x="assets/img/testimonials/1.jpg"/>
                                        </div>
                                        <div className="testimonial-text">
                                            <p>
                                                "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et. 
                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et. 
                                                Lorem ipsum dolor sit amet, consectetur..."<br/>
                                                <a href="#">Lorem Ipsum, dolor.co.uk</a>
                                            </p>
                                        </div>
                                    </div>
                                    <div role="tabpanel" className="tab-pane fade" id="tab2">
                                        <div className="testimonial-image">
                                            <img src="assets/img/testimonials/2.jpg" alt="" data-at2x="assets/img/testimonials/2.jpg"/>
                                        </div>
                                        <div className="testimonial-text">
                                            <p>
                                                "Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip 
                                                ex ea commodo consequat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit 
                                                lobortis nisl ut aliquip ex ea commodo consequat..."<br/>
                                                <a href="#">Minim Veniam, nostrud.com</a>
                                            </p>
                                        </div>
                                    </div>
                                    <div role="tabpanel" className="tab-pane fade" id="tab3">
                                        <div className="testimonial-image">
                                            <img src="assets/img/testimonials/3.jpg" alt="" data-at2x="assets/img/testimonials/3.jpg"/>
                                        </div>
                                        <div className="testimonial-text">
                                            <p>
                                                "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et. 
                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et. 
                                                Lorem ipsum dolor sit amet, consectetur..."<br/>
                                                <a href="#">Lorem Ipsum, dolor.co.uk</a>
                                            </p>
                                        </div>
                                    </div>
                                    <div role="tabpanel" className="tab-pane fade" id="tab4">
                                        <div className="testimonial-image">
                                            <img src="assets/img/testimonials/1.jpg" alt="" data-at2x="assets/img/testimonials/1.jpg"/>
                                        </div>
                                        <div className="testimonial-text">
                                            <p>
                                                "Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip 
                                                ex ea commodo consequat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit 
                                                lobortis nisl ut aliquip ex ea commodo consequat..."<br/>
                                                <a href="#">Minim Veniam, nostrud.com</a>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <ul className="nav nav-tabs" role="tablist">
                                    <li role="presentation" className="active">
                                        <a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab"></a>
                                    </li>
                                    <li role="presentation">
                                        <a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab"></a>
                                    </li>
                                    <li role="presentation">
                                        <a href="#tab3" aria-controls="tab3" role="tab" data-toggle="tab"></a>
                                    </li>
                                    <li role="presentation">
                                        <a href="#tab4" aria-controls="tab4" role="tab" data-toggle="tab"></a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <footer>
                <div className="container">
                    <div className="row">
                        <div className="col-sm-3 footer-box wow fadeInUp">
                            <h4>About Us</h4>
                            <div className="footer-box-text">
                                <p>
                                    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et. 
                                    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et.
                                </p>
                                <p><a href="about.html">Read more...</a></p>
                            </div>
                        </div>
                        <div className="col-sm-3 footer-box wow fadeInDown">
                            <h4>Email Updates</h4>
                            <div className="footer-box-text footer-box-text-subscribe">
                                <p>Enter your email and you'll be one of the first to get new updates:</p>
                                <form role="form" action="assets/subscribe.php" method="post">
                                    <div className="form-group">
                                        <label className="sr-only" for="subscribe-email">Email address</label>
                                        <input type="text" name="email" placeholder="Email..." className="subscribe-email" id="subscribe-email"/>
                                    </div>
                                    <button type="submit" className="btn">Subscribe</button>
                                </form>
                                <p className="success-message"></p>
                                <p className="error-message"></p>
                            </div>
                        </div>
                        <div className="col-sm-3 footer-box wow fadeInUp">
                            <h4>Flickr Photos</h4>
                            <div className="footer-box-text flickr-feed"></div>
                        </div>
                        <div className="col-sm-3 footer-box wow fadeInDown">
                            <h4>Contact Us</h4>
                            <div className="footer-box-text footer-box-text-contact">
                                <p><i className="fa fa-map-marker"></i> Address: Via Principe Amedeo 9, 10100, Torino, TO, Italy</p>
                                <p><i className="fa fa-phone"></i> Phone: 0039 333 12 68 347</p>
                                <p><i className="fa fa-user"></i> Skype: Andia_Agency</p>
                                <p><i className="fa fa-envelope"></i> Email: <a href="">contact@andia.co.uk</a></p>
                            </div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-12 wow fadeIn">
                            <div className="footer-border"></div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-7 footer-copyright wow fadeIn">
                            <p>Copyright 2012 Andia - All rights reserved. Template by <a href="http://azmind.com">Azmind</a>.</p>
                        </div>
                        <div className="col-sm-5 footer-social wow fadeIn">
                            <a href="#"><i className="fa fa-facebook"></i></a>
                            <a href="#"><i className="fa fa-dribbble"></i></a>
                            <a href="#"><i className="fa fa-twitter"></i></a>
                            <a href="#"><i className="fa fa-pinterest"></i></a>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
}

module.exports = Root
