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
  #logo{
    width: 100%;
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
 <div  id="page-top" <?php body_class(); ?> >

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase" id="mainNav">
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="http://localhost:8888/wordpress/" style="font-size: 30px;">SUB BOARD I. INC <br/><span style="font-size: 15px; position: relative; bottom:50%;">  INSURANCE <span> </a>
        <button class="navbar-toggler navbar-toggler-right text-uppercase bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">


            <ul class="navbar-nav ml-auto">
              <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="http://localhost:8888/wordpress/sbi-insurance/forms/" style="font-size: 15px;">FORMS</a></li>
              <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="http://localhost:8888/wordpress/sbi-insurance/students/" style="font-size: 15px;">STUDENTS</a></li>
              <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#deadlines" style="font-size: 15px;">PLANS & DEADLINES</a></li>
              <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="http://localhost:8888/wordpress/sbi-insurance/payments/" style="font-size: 15px;">PAYMENTS</a></li>
              <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#contact-us" style="font-size: 15px;">CONTACT US</a></li>


          </ul>
        </div>

      </div>



    </nav>

    <!-- Header -->
    <header style="text-align: center;color: #fff; background: #00a3da;;" class="masthead text-white text-center" >
      <div class="container">


         <div class="col-lg-12 px-0" >

              <img src="<?php echo get_template_directory_uri(); ?>/img/Logos/insurancelogo2.png" alt="" width="1100" height="500">
          </div>
           <!-- <div class="col-lg-2 px-0" style="background-color:#ffffff">

               <p>hiiii</p>
            </div> -->
        </div>



    </header>



    <!-- Gets content from page from WP admin-->
















</div>

<div class = "" id= "content">
 <div class = "row" >
    <?php if(have_posts()): while (have_posts()): the_post();?>
      <div class="text-center"><?php the_content(); ?> </div>
    <?php endwhile; else: ?>
    <!--  <p>Sorry, no page found.</p>-->
<?php endif; ?>
</div>
</div>


<!-- Inserts footer.php -->
<footer class="footer text-center" id = "footer">
  <div class="container">
    <div class="row">
      <div class="footer-col col-md-4">
          <h1 class="text-uppercase mb-4">Location</h1>
          <p style="font-size: 20px" class="lead mb-0"><br>Student Medical Insurance<br>1 Capen<br>Univerity at Buffalo<br>Buffalo, NY 14260-2100<br>Phone: (716) 645-3036<br>Fax: (716) 645-3465<br>Email: asksmi@buffalo.edu</p>
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

    </div>
  </div>
</footer>
