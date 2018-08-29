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
        <a class="navbar-brand js-scroll-trigger" href="http://localhost:8888/wordpress/" style="font-size: 30px;">SUB BOARD I. INC <br/><span style="font-size: 15px; position: relative; bottom:50%;">  GAMING <span> </a>
        <button class="navbar-toggler navbar-toggler-right text-uppercase bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#about_us" style="font-size: 15px;">ABOUT US</a></li>
            <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#contact_us" style="font-size: 15px;">CONTACT US</a></li>

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
