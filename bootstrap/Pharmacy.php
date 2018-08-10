<?php /*Template Name: Pharmacy*/ get_header(); ?>


<style media="screen">
  /* Creates space between navbar and content */
  #page-top{
    padding-top: 2%
  }
  header{
    height: 80%;
  }

  footer {
     position:relative;
     bottom:0;
     width:100%;

  }
  #spacer{
    position: relative;
    height: 5%;
  }

</style>


 <section  id="page-top" <?php body_class(); ?> >

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase" id="mainNav">
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="http://localhost:8888/wordpress/" style="font-size: 30px;">SUB BOARD I.INC</a>
        <button class="navbar-toggler navbar-toggler-right text-uppercase bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#portfolio" style="font-size: 15px;">SERVICES</a></li>
            <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="http://localhost:8888/wordpress/sample-page/" style="font-size: 15px;">CONTACT US</a></li>

        </ul>

        </div>

      </div>
    </nav>

    <header style="background-color: #04447c" >
        <div class="container">
          <div class="row  mx-0">
            <div class="col-lg-2 px-0" style="background-color:#ffffff">
                <p>hiiii</p>
            </div>
           <div class="col-lg-8 px-0" >
                <img class="img-responsive" src="<?php echo get_template_directory_uri(); ?>/img/Logos/pharmacylogo.jpg" alt="" width= 800px>
            </div>
             <div class="col-lg-2 px-0" style="background-color:#ffffff">
                 <p>hiiii</p>
              </div>
          </div>
          <!-- END OF ROW -->
          <!-- THIS JUST CREATES HEGHT FOR THE HEADER -->
          <div id="spacer">
            <p></p>
            <p></p>
          </div>
          </div>
       </div>
    </header>
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






<!-- Inserts footer.php -->
 <?php get_footer(); ?>
