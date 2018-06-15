<!-- Inserts header.php -->
<?php get_header(); ?>

<!-- Header -->
<header style="background-color: #0099cc;" class="masthead text-white text-center" >
  <div class="container">
    <img class="img-fluid mb-5 d-block mx-auto" src="<?php echo get_template_directory_uri(); ?>/img/profile.png" alt="">
    <h1 class="text-uppercase mb-0"><?php bloginfo('name'); ?></h1> <!-- Use WP admin function site title -->

    </br>
    <h3 class="font-weight-light">-Student Medical Insurance - Box Office - Off Campus Housing - Legal Assistance - Safety Service <br>- Health &amp; Safety Services - Pharmacy - Student Government Accounting - Radio - Gaming - Dry Cleaning</h3>
    <span style="color:#ffd800;">Sub-Board I, Inc. is a non-for-profit corporation, founded by U.B. students in 1970, designed to enhance the quality of student life at U.B.</span>
  </div>
</header>

<!-- Portfolio Grid Section -->
<section class="portfolio" id="portfolio">

  <div class="container" >
    <h2 class="text-center text-uppercase text-secondary mb-0">SERVICES</h2>
    <hr class="star-dark mb-5">

    <div class="row">
      <div class="col-md-6 col-lg-4">
        <a class="portfolio-item d-block mx-auto" href="http://healthinsurance.buffalo.edu/">
          <div class="portfolio-item-caption d-flex position-absolute h-100 w-100">
            <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
              <i class="fa fa-search-plus fa-3x"></i>
            </div>
          </div>
            <img class="img-fluid" src="<?php echo get_template_directory_uri(); ?>/img/portfolio/cabin.png" alt="" >
          </a>
      </div>

      <div class="col-md-6 col-lg-4">
        <a class="portfolio-item d-block mx-auto" href="https://subboard.com:8081/pharmacy.html">
          <div class="portfolio-item-caption d-flex position-absolute h-100 w-100">
            <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
              <i class="fa fa-search-plus fa-3x"></i>
            </div>
          </div>
          <img class="img-fluid" src="<?php echo get_template_directory_uri(); ?>/img/portfolio/cake.png" alt="">
        </a>
      </div>
      <div class="col-md-6 col-lg-4">
        <a class="portfolio-item d-block mx-auto" href="https://subboard.com:8081/healthed.html">
          <div class="portfolio-item-caption d-flex position-absolute h-100 w-100">
            <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
              <i class="fa fa-search-plus fa-3x"></i>
            </div>
          </div>
          <img class="img-fluid" src="<?php echo get_template_directory_uri(); ?>/img/portfolio/circus.png" alt="">
        </a>
      </div>
      <div class="col-md-6 col-lg-4">
        <a class="portfolio-item d-block mx-auto" href="https://subboard.com:8081/legal.html">
          <div class="portfolio-item-caption d-flex position-absolute h-100 w-100">
            <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
              <i class="fa fa-search-plus fa-3x"></i>
            </div>
          </div>
          <img class="img-fluid" src="<?php echo get_template_directory_uri(); ?>/img/portfolio/game.png" alt="">
        </a>
      </div>
      <div class="col-md-6 col-lg-4">
        <a class="portfolio-item d-block mx-auto" href="#portfolio-modal-5">
          <div class="portfolio-item-caption d-flex position-absolute h-100 w-100">
            <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
              <i class="fa fa-search-plus fa-3x"></i>
            </div>
          </div>
          <img class="img-fluid" src="<?php echo get_template_directory_uri(); ?>/img/portfolio/safe.png" alt="">
        </a>
      </div>
      <div class="col-md-6 col-lg-4">
        <a class="portfolio-item d-block mx-auto" href="#portfolio-modal-6">
          <div class="portfolio-item-caption d-flex position-absolute h-100 w-100">
            <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
              <i class="fa fa-search-plus fa-3x"></i>
            </div>
          </div>
          <img class="img-fluid" src="<?php echo get_template_directory_uri(); ?>/img/portfolio/submarine.png" alt="">
        </a>
      </div>
    </div>
  </div>
</section>
<!-- Inserts footer.php -->
<?php get_footer(); ?>






<!-- About Section -->
<!-- <section class="bg-primary text-white mb-0" id="about">
  <div class="container">
    <h2 class="text-center text-uppercase text-white">About</h2>
    <hr class="star-light mb-5">
    <div class="row">
      <div class="col-lg-4 ml-auto">
        <p class="lead">Freelancer is a free bootstrap theme created by Start Bootstrap. The download includes the complete source files including HTML, CSS, and JavaScript as well as optional LESS stylesheets for easy customization.</p>
      </div>
      <div class="col-lg-4 mr-auto">
        <p class="lead">Whether you're a student looking to showcase your work, a professional looking to attract clients, or a graphic artist looking to share your projects, this template is the perfect starting point!</p>
      </div>
    </div>
    <div class="text-center mt-4">
      <a class="btn btn-xl btn-outline-light" href="#">
        <i class="fa fa-download mr-2"></i>
        Download Now!
      </a>
    </div>
  </div>
</section> -->

<!-- Contact Section -->
<!-- <section id="contact">
  <div class="container">
    <h2 class="text-center text-uppercase text-secondary mb-0">Contact Me</h2>
    <hr class="star-dark mb-5">
    <div class="row">
      <div class="col-lg-8 mx-auto">

        <form name="sentMessage" id="contactForm" novalidate="novalidate">
          <div class="control-group">
            <div class="form-group floating-label-form-group controls mb-0 pb-2">
              <label>Name</label>
              <input class="form-control" id="name" type="text" placeholder="Name" required="required" data-validation-required-message="Please enter your name.">
              <p class="help-block text-danger"></p>
            </div>
          </div>
          <div class="control-group">
            <div class="form-group floating-label-form-group controls mb-0 pb-2">
              <label>Email Address</label>
              <input class="form-control" id="email" type="email" placeholder="Email Address" required="required" data-validation-required-message="Please enter your email address.">
              <p class="help-block text-danger"></p>
            </div>
          </div>
          <div class="control-group">
            <div class="form-group floating-label-form-group controls mb-0 pb-2">
              <label>Phone Number</label>
              <input class="form-control" id="phone" type="tel" placeholder="Phone Number" required="required" data-validation-required-message="Please enter your phone number.">
              <p class="help-block text-danger"></p>
            </div>
          </div>
          <div class="control-group">
            <div class="form-group floating-label-form-group controls mb-0 pb-2">
              <label>Message</label>
              <textarea class="form-control" id="message" rows="5" placeholder="Message" required="required" data-validation-required-message="Please enter a message."></textarea>
              <p class="help-block text-danger"></p>
            </div>
          </div>
          <br>
          <div id="success"></div>
          <div class="form-group">
            <button type="submit" class="btn btn-primary btn-xl" id="sendMessageButton">Send</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</section> -->
