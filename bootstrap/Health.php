<?php /*Template Name: Health*/ get_header(); ?>


<style media="screen">

  #page-top{
    padding-top: 4%
  }
  header{
    height: 80%;
  }
  .portfolio-item{
    border-style: solid;
    border-width: 2px;

  }

  .portfolio-link{
    padding: 10px,10px,10px,10px;
  }
  #services{
    position: relative;
    left: 10%;
  }
  .fa:hover {
    opacity: 0.7;
  }
  .fa {
      display: inline-block;
      font: normal normal normal 14px/1 FontAwesome;
      font-size: inherit;
      text-rendering: auto;
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
  }

</style>

<!-- Header -->
<header style="text-align: center;color: #fff; background: #8BBC3C;" class="masthead text-white text-center" >
  <div class="container">
    <img class="img-fluid mb-5 d-block mx-auto" src="<?php echo get_template_directory_uri(); ?>/drycleaning/img/Logos/SBIHealthedlogo2.png" alt="">

    </br>
  </div>


</header>
 <section  id="page-top" <?php body_class(); ?> >

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase" id="mainNav">
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="http://localhost:8888/wordpress/" style="font-size: 30px;">SUB BOARD I. INC <br/><span style="font-size: 15px; position: relative; bottom:50%;">  HEALTHED <span> </a>
        <button class="navbar-toggler navbar-toggler-right text-uppercase bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">


            <ul class="navbar-nav ml-auto">

              <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#about_us" style="font-size: 15px;">ABOUT US</a></li>

          </ul>
        </div>

      </div>



    </nav>
</section>


<!-- Portfolio -->
<section id="portfolio">
  <div class="container">
    <div class="row">
      <div class="col-lg-12 text-center">
        <h1>SERVICES</h1>
        <hr class="star-primary">
      </div>
    </div>
    <div class="row">
      <div class="col-sm-4 ">
        <a href="http://localhost:8888/wordpress/safety-shuttle-schedule/" class="portfolio-link" data-toggle="modal">
          <div class="caption">
            <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
              <i class="fa fa-search-plus fa-3x"></i>
            </div>
          </div>
         <img src="<?php echo get_template_directory_uri(); ?>/img/HealthEd/SafetyShuttleSchedule.png"  class="img-responsive" alt="">
        </a>
      </div>
      <div class="col-sm-4 ">
        <a href="http://localhost:8888/wordpress/sbi-health/crisis-services/" class="portfolio-link" data-toggle="modal">
          <div class="caption">
            <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
              <i class="fa fa-search-plus fa-3x"></i>
            </div>
          </div>
         <img src="<?php echo get_template_directory_uri(); ?>/img/HealthEd/CrisisServices.png" class="img-responsive" alt="">
        </a>
      </div>
      <div class="col-sm-4 ">
        <a href="http://localhost:8888/wordpress/no-woman-left-behind/" class="portfolio-link" data-toggle="modal">
          <div class="caption">
            <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
              <i class="fa fa-search-plus fa-3x"></i>
            </div>
          </div>
             <img src="<?php echo get_template_directory_uri(); ?>/img/HealthEd/NoWomanLeftBehind.png" class="img-responsive" alt="">
        </a>
      </div>
      <div class="col-sm-4 ">
        <a href="http://localhost:8888/wordpress/safety-shuttle-policies/" class="portfolio-link" data-toggle="modal">
          <div class="caption">
            <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
              <i class="fa fa-search-plus fa-3x"></i>
            </div>
          </div>
          <img src="<?php echo get_template_directory_uri(); ?>/img/HealthEd/SafetyShuttlePolicies.png"  class="img-responsive" alt="">
        </a>
      </div>
      <div class="col-sm-4 ">
        <a href="http://localhost:8888/wordpress/awareness-events/" class="portfolio-link" data-toggle="modal">
          <div class="caption">
            <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
              <i class="fa fa-search-plus fa-3x"></i>
            </div>
          </div>
          <img src="<?php echo get_template_directory_uri(); ?>/img/HealthEd/AwarenessEvents.png" class="img-responsive" alt="">
        </a>
      </div>
    </div>
  </div>
</section>





<!-- Gets content from page from WP admin-->
<div class = "container">
  <div class = "row" >
    <?php if(have_posts()): while (have_posts()): the_post();?>
      <div class="col-lg-12 text-center"><?php the_content(); ?> </div>
    <?php endwhile; else: ?>
    <!--  <p>Sorry, no page found.</p>-->
<?php endif; ?>
  </div>
</div>

</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
<!-- Inserts footer.php -->

<footer class="footer text-center" id = "footer">
  <div class="container">
    <div class="row">
      <div class="col-md-4 mb-5 mb-lg-0">
        <h1 class="text-uppercase mb-4">Location</h1>
        <p style="font-size: 20px" class="lead mb-0">State Univerity at Buffalo
          <br>315 Student Union<br>Amherst, NY 14260
      </div>
      <div class="col-md-4 mb-5 mb-lg-0">
        <h1 class="text-uppercase mb-4">Around the Web</h1>
        <ul class="list-inline mb-0">
          <li class="list-inline-item">
            <a class="btn btn-outline-light btn-social text-center rounded-circle" href="#" >
              <i class="fa fa-fw fa-facebook" ></i>
            </a>
          </li>
          <li class="list-inline-item">
            <a class="btn btn-outline-light btn-social text-center rounded-circle" href="#">
              <i class="fa fa-fw fa-twitter" ></i>
            </a>
          </li>

        </ul>

      </div>
      <div class="col-md-4">

        <p style="font-size: 15px">Template Powered by: Freelancer<br>
       Freelance is a free to use, open source Bootstrap theme created by <a href="http://startbootstrap.com" target="_blank">Start Bootstrap</a>.</p>

      </div>
    </div>
  </div>
</footer>
