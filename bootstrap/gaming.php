<?php /*Template Name: Gaming*/ get_header(); ?>


<style media="screen">
  /* Creates space between navbar and content */
  #page-top{
    padding-top: 3%
  }
  header{
    position: static;
    height: 80%;
    width: 100%;
  }
  footer {
     position:relative;
     bottom:0;
     width:100%;

  }
  section{
    height: 100%;
  }

  .row_height{
    height: 40%;
  }


  #content{
    padding-top: 5%;
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

    <header id= "head" style="background-color: #B4A856" >
        <div class="container">
          <div class="row  mx-0">
            <div class="col-lg-2 px-0" style="background-color:#ffffff">
                <p></p>
            </div>
           <div class="col-lg-8 px-0" >
                <img class="img-responsive" src="<?php echo get_template_directory_uri(); ?>/drycleaning/img/Logos/SBIGamingLogo.png" alt="" width= 800px>
            </div>
             <div class="col-lg-2 px-0" style="background-color:#ffffff">
                 <p></p>
              </div>
          </div>
          <div class="row  mx-0 row_height">
            <div class="col-lg-2 px-0" style="background-color:#ffffff">
                <p></p>
            </div>
           <div class="col-lg-8 px-0" style="background-color:#ffffff">
                <p></p>
            </div>
             <div class="col-lg-2 px-0" style="background-color:#ffffff">
                 <p></p>
              </div>
          </div>
          <!-- END OF ROW -->
          </div>
          <!-- END OF CONTAINER -->

          <!-- THIS JUST CREATES HEGHT FOR THE HEADER -->
          <section>
            <p></p>
          </section>
    



          </div>
       </div>
    </header>


    <!-- Gets content from page from WP admin-->
    <div id ="content" class = "container" >
      <div class = "row" >
        <?php if(have_posts()): while (have_posts()): the_post();?>
          <div><?php the_content(); ?> </div>
        <?php endwhile; else: ?>
        <!--  <p>Sorry, no page found.</p>-->
    <?php endif; ?>
      </div>

    </div>

    <? if (have_posts()):while(have_posts()): the_post(); the_content(); endwhile; endif; ?>

</section>



<!-- Inserts footer.php -->
 <?php get_footer(); ?>
