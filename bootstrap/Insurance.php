<?php /*Template Name: Insurance*/ get_header(); ?>


<style media="screen">

  #page-top{
    padding-top: 0%
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
  #content{
    padding-top: 0px;
  }
</style>
 <div  id="page-top" <?php body_class(); ?> >

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase" id="mainNav">
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="http://localhost:8888/wordpress/" style="font-size: 30px;">SUB BOARD I, INC</a>
        <button class="navbar-toggler navbar-toggler-right text-uppercase bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">


            <ul class="navbar-nav ml-auto">
              <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="" style="font-size: 15px;">FORMS</a></li>
              <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="" style="font-size: 15px;">STUDENTS</a></li>
              <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="" style="font-size: 15px;">PLANS & DEADLINES</a></li>
              <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="" style="font-size: 15px;">PAYMENTS</a></li>
              <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="" style="font-size: 15px;">CONTACT US</a></li>


          </ul>
        </div>

      </div>



    </nav>

    <!-- Header -->
    <header style="text-align: center;color: #fff; background: #00a3da;;" class="masthead text-white text-center" >
      <div class="container">
        <div class="row  mx-0">
          <div class="col-lg-2 px-0" style="background-color:#ffffff">
              <p>hiiii</p>
          </div>
         <div class="col-lg-8 px-0" >
              <img class="img-responsive" src="<?php echo get_template_directory_uri(); ?>/img/Logos/insurancelogo2.png" alt="" width= 800px>
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


    </header>
</div>


<!-- Gets content from page from WP admin-->
<div class = "container" id= "content">
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
