<?php /*Template Name: Jobs*/ get_header(); ?>


<style media="screen">
  /* Creates space between navbar and content */
  #page-top{
    padding-top: 7%
  }
  header{
    height: 80%;
  }
  footer{
    position: fixed;
     left: 0;
     bottom: 0;
     width: 100%;

  }

</style>


 <section  id="page-top" <?php body_class(); ?> >

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase" id="mainNav">
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="http://localhost:8888/wordpress/" style="font-size: 30px;">SUB BOARD I, INC</a>
        <button class="navbar-toggler navbar-toggler-right text-uppercase bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">


            <!-- <ul class="navbar-nav ml-auto">
              <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#portfolio" style="font-size: 15px;">SERVICES</a></li>
              <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="http://localhost:8888/wordpress/sample-page/" style="font-size: 15px;">ABOUT US</a></li>

          </ul> -->
        </div>

      </div>



    </nav>

    <!-- Gets content from page from WP admin-->
    <div class = "container">
      <div class = "row" >
        <?php if(have_posts()): while (have_posts()): the_post();?>
          <p><?php the_content(); ?> </p>
        <?php endwhile; else: ?>
        <!--  <p>Sorry, no page found.</p>-->
    <?php endif; ?>
      </div>
    </div>

</section>



<!-- Inserts footer.php -->
<?php get_footer(); ?>
