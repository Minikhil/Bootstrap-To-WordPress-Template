<?php /*Template Name: customHome*/ get_header(); ?>
<!--<style media="screen">
  #banner{
    height: 100%;
  }
  .portfolio-item{
    border-style: solid;
    border-width: 1px;


  }
  .portfolio-item:hover {
      background-color: yellow;
  }
  .portfolio-link{
    padding: 10px,10px,10px,10px;
  }
  .classWithPad { margin:10px; padding:10px; }
</style>-->

<body>


<nav class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase" id="mainNav">
  <div class="container">
    <a class="navbar-brand js-scroll-trigger" href="http://localhost:8888/wordpress/" style="font-size: 30px;">SUB BOARD I, INC</a>
    <button class="navbar-toggler navbar-toggler-right text-uppercase bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
      Menu
      <i class="fa fa-bars"></i>
    </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">


        <ul class="navbar-nav ml-auto">
          <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#portfolio" style="font-size: 15px;">SERVICES</a></li>
          <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="http://localhost:8888/wordpress/sample-page/" style="font-size: 15px;">ABOUT US</a></li>

      </ul>
    </div>

  </div>



</nav>

<!-- Header -->
<header style="background-color: #0099cc;" class="masthead text-white text-center" >
  <div class="container" id = "banner">
    <img class="img-fluid mb-5 d-block mx-auto" src="<?php echo get_template_directory_uri(); ?>/img/sbi_logo.png" alt="">
    <span class="text-uppercase mb-0" style="font-weight: 700; font-size: 80px;"><?php bloginfo('name'); ?></span>

      </br>
      <h3 class="font-weight-light">-Student Medical Insurance - Box Office - Off Campus Housing - Legal Assistance - Safety Service <br>- Health &amp; Safety Services - Pharmacy - Student Government Accounting - Radio - Gaming - Dry Cleaning</h3>
      <span style="color:#ffd800;">Sub-Board I, Inc. is a non-for-profit corporation, founded by U.B. students in 1970, designed to enhance the quality of student life at U.B.</span>
  <!--</div>
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
</br>-->


</header>

<!-- Portfolio Grid Section -->
<section id="portfolio">
   <div class="container">
     <div class="row">
        <div class="col-lg-12 text-center">
           <p style="font-size: 50px; font-weight: bold;">SERVICES</p>
        </div>
     </div>
      <div class="row">
         <div class="col-sm-3  portfolio-item">
           <div class="classWithPad">
             <a href="http://healthinsurance.buffalo.edu" class="portfolio-link" data-toggle="modal">
                <img src="<?php echo get_template_directory_uri(); ?>/img/Logos/insurancelogo.jpg"  class="img-responsive" alt="">
             </a>
           </div>

         </div>
         <div class="col-sm-3 portfolio-item">
            <a href="./pharmacy.html" class="portfolio-link" data-toggle="modal">
               <img src="<?php echo get_template_directory_uri(); ?>/img/Logos/pharmacylogo.jpg" class="img-responsive" alt="">
            </a>
         </div>
         <div class="col-sm-3 portfolio-item">

            <a href="http://localhost:8888/wordpress/sbi-health/" class="portfolio-link" data-toggle="modal">
               <img src="<?php echo get_template_directory_uri(); ?>/img/Logos/health&safety.jpg" class="img-responsive" alt="">
            </a>
         </div>
         <div class="col-sm-3 portfolio-item">

            <a href="./legal.html" class="portfolio-link" data-toggle="modal">
               <img src="<?php echo get_template_directory_uri(); ?>/img/Logos/legallogo.jpg" class="img-responsive" alt="">
            </a>
         </div>
         <div class="col-sm-3 portfolio-item">

            <a href="http://wrub.org" class="portfolio-link">

               <img src="<?php echo get_template_directory_uri(); ?>/img/Logos/wrublogo.jpg" class="img-responsive" alt="">
            </a>
         </div>
         <div class="col-sm-3 portfolio-item">

            <a href="http://sbiticket.buffalo.edu/" class="portfolio-link" data-toggle="modal">

               <img src="<?php echo get_template_directory_uri(); ?>/img/Logos/ticketlogo.jpg" class="img-responsive" alt="">
            </a>
         </div>
         <div class="col-sm-3 portfolio-item">

            <a href="/och/" class="portfolio-link" data-toggle="modal">
               <img src="<?php echo get_template_directory_uri(); ?>/img/Logos/housinglogo.jpg" class="img-responsive" alt="">
            </a>
         </div>
         <div class="col-sm-3 portfolio-item">

            <a href="./drycleaning.html" class="portfolio-link" data-toggle="modal">
               <img src="<?php echo get_template_directory_uri(); ?>/img/Logos/SBIDryCleaninglogo.png" class="img-responsive" alt="">
            </a>
         </div>
         <div class="col-sm-3 portfolio-item">

            <a href="./gaming.html" class="portfolio-link" data-toggle="modal">
               <img src="<?php echo get_template_directory_uri(); ?>/img/Logos/SBIGamingLogo.png" class="img-responsive" alt="">
            </a>
         </div>
         <div class="col-sm-3 portfolio-item">

            <a href="http://localhost:8888/wordpress/jobs/" class="portfolio-link" data-toggle="modal">

               <img src="<?php echo get_template_directory_uri(); ?>/img/Logos/Jobs.png" class="img-responsive" alt="">
            </a>
         </div>
         <!-- Staff Directory -->
         <div class="col-sm-3 portfolio-item">

            <a href="http://localhost:8888/wordpress/staff/" class="portfolio-link" data-toggle="modal">
               <!---Ask Arora about how to have a dialog box to pop up-->

               <img src="<?php echo get_template_directory_uri(); ?>/img/Logos/StaffDirectory.png" class="img-responsive" alt="">
            </a>
         </div>
         <div class="col-sm-3 portfolio-item">

            <a href="./accounting/accounting.html" class="portfolio-link" data-toggle="modal">

               <img src="<?php echo get_template_directory_uri(); ?>/img/Logos/accountinglogo.jpg" class="img-responsive" alt="">
            </a>
         </div>
      </div>
   </div>
</section>

</body>

<!-- Inserts footer.php -->
<?php get_footer(); ?>
