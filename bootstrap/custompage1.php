<?php /*Template Name: custompage1*/ get_header(); ?>

<!-- Header -->
<header style="text-align: center;color: #fff; background: #8BBC3C;" class="masthead text-white text-center" >
  <div class="container">
    <img class="img-fluid mb-5 d-block mx-auto" src="<?php echo get_template_directory_uri(); ?>/img/Logos_old/SBIHealthedlogo1.jpg" alt="">

    </br>
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

</header>
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
  .portfolio-item:hover {
      background-color: yellow;
  }
  .portfolio-link{
    padding: 10px,10px,10px,10px;
  }
  #services{
    position: relative;
    left: 10%;
  }
</style>
 <section  id="page-top" <?php body_class(); ?> >

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase" id="mainNav">
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="http://localhost:8888/wordpress/">SUB BOARD I, INC</a>
      </div>
      <a class="navbar" href="index.php">SERVICES</a>
      <a class="navbar" href="index.php">ABOUT US</a>
    </nav>

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

</section><!-- Portfolio Grid Section -->
<section id="portfolio">
   <div class="container" id = "services">
     <!-- <div class="row">
        <div class="col-lg-12 text-center">
           <p style="font-size: 50px; font-weight: bold;">SERVICES</p>
        </div>
     </div> -->
      <div class="row">
         <div class="col-sm-3 portfolio-item">
            <a href="http://healthinsurance.buffalo.edu" class="portfolio-link" data-toggle="modal">
               <img src="<?php echo get_template_directory_uri(); ?>/img/HealthEd/SafetyShuttleSchedule.png"  class="img-responsive" alt="">
            </a>
         </div>
         <div class="col-sm-3 portfolio-item">
            <a href="./pharmacy.html" class="portfolio-link" data-toggle="modal">
               <img src="<?php echo get_template_directory_uri(); ?>/img/HealthEd/CrisisServices.png" class="img-responsive" alt="">
            </a>
         </div>
         <div class="col-sm-3 portfolio-item">

            <a href="http://localhost:8888/wordpress/sbi-health/" class="portfolio-link" data-toggle="modal">
               <img src="<?php echo get_template_directory_uri(); ?>/img/HealthEd/NoWomanLeftBehind.png" class="img-responsive" alt="">
            </a>
         </div>
      </div>
      <div class="row">
         <div class="col-sm-3 portfolio-item">
            <a href="http://healthinsurance.buffalo.edu" class="portfolio-link" data-toggle="modal">
               <img src="<?php echo get_template_directory_uri(); ?>/img/HealthEd/SafetyShuttlePolicies.png"  class="img-responsive" alt="">
            </a>
         </div>
         <div class="col-sm-3 portfolio-item">
            <a href="./pharmacy.html" class="portfolio-link" data-toggle="modal">
               <img src="<?php echo get_template_directory_uri(); ?>/img/HealthEd/AwarenessEvents.png" class="img-responsive" alt="">
            </a>
         </div>

      </div>
   </div>
</section>


<!-- Inserts footer.php -->
<?php get_footer(); ?>
