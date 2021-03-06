<%-- 
    Document   : create_admin
    Created on : 29 Jun, 2015, 12:19:26 PM
    Author     : sukanya

--%>

<%    String user_name = (String) session.getAttribute("user_name");
    String user_type = (String) session.getAttribute("user_type");
    String user_code = (String) session.getAttribute("user_code");
    String cus_id = (String) session.getAttribute("cus_id");
    if (user_name != null) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%=config.getServletContext().getInitParameter("projectname")%> | Daily points Gain</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <!-- Bootstrap 3.3.4 -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Font Awesome Icons -->
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons -->
        <link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <!-- jvectormap -->
        <link href="plugins/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
        <!-- Theme style -->
        <link href="dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
        <!-- AdminLTE Skins. Choose a skin from the css/skins
             folder instead of downloading all of them to reduce the load. -->
        <link href="dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="css/datepicker.min.css"/>
        <link rel="stylesheet" href="css/datepicker3.min.css"/>
        <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
        <script src="js/bootstrap-datepicker.min.js"></script>

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
            <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->


    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">

            <%@include file="header/dashboard_header.jsp" %>
            <!-- Left side column. contains the logo and sidebar -->
            <%@include file="menu/admin_menu.jsp" %>

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <section class="content-header">
                    <h1>
                        Gain daily points

                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">Dashboard</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">
                    <div class="row">
                        <!-- left column -->
                        <%                            try {
                                if (request.getParameter("status").equals("1")) {
                        %>
                        <div style=" background: green; padding: 3px 3px 3px 3px; width: 97% ; margin-left: 15px; margin-bottom: 5px;color: #ffffff; ">
                            Admin Created
                        </div>
                        <%} else {%>
                        <div style=" background: red; padding: 3px 3px 3px 3px; width: 97% ;margin-left: 5px;margin-bottom: 5px;color: #ffffff; ">
                            There Goes Something Wrong 
                        </div>
                        <%}
                            } catch (Exception e) {
                            }%>
                        <form action="list_of_daily_points_gain.jsp" method="post">
                            <div class="col-xs-12">
                                <!-- general form elements -->
                                <div class="box box-primary">

                                    <!-- form start -->

                                    <div class="box-body">
                                        <div class="form-group">
                                        
                                                <table id="table1" class="table table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Member Id</th>
                                                            <th>Name</th>
                                                            <th>Points</th>
                                                            <th>Date</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                        java.sql.PreparedStatement ps = null;
                                                        java.sql.ResultSet rs = null;
                                                        ArrayList<String>memberList = new ArrayList<String>();
                                                        try{
                                                            ps = conn.prepareStatement("SELECT DISTINCT member_id FROM  loyalty_member_login_info_datewise WHERE status = 'Check In' ");
                                                            rs = ps.executeQuery();
                                                            while(rs.next()){
                                                                String memid = "";
                                                                try{memid = rs.getString("member_id");if(memid==null)memid="";}catch(Exception e){e.printStackTrace();}
                                                                if(!memid.equals("")){
                                                                    memberList.add(memid);
                                                                }
                                                            }
                                                            
                                                            DateFormat dft = new SimpleDateFormat("yyyy-MM-dd");
                                                            DateFormat new_dft = new SimpleDateFormat("dd/MM/yyyy");
                                                            java.util.Date dt = new java.util.Date();
                                                            String curdt = dft.format(dt);
                                                            String disp_curdt = new_dft.format(dt);
                                                            for(int j=0;j<memberList.size();j++){System.out.println("SELECT nmrd.member_id,nmrd.fullname,sum(lid.points) FROM loyalty_member_login_info_datewise lid,sengroup_new_member_reg_details nmrd WHERE lid.member_id=nmrd.member_id AND lid.status='Check In' AND lid.member_id='"+memberList.get(j)+"' AND lid.create_date='"+curdt+"'");
                                                            ps = conn.prepareStatement("SELECT nmrd.fullname,sum(lid.points) FROM loyalty_member_login_info_datewise lid,sengroup_new_member_reg_details nmrd WHERE lid.member_id=nmrd.member_id AND lid.status='Check In' AND lid.member_id='"+memberList.get(j)+"' AND lid.create_date='"+curdt+"'");
                                                            rs = ps.executeQuery();
                                                            while(rs.next()){
                                                                String fname = "";
                                                                try{fname = rs.getString(1);if(fname==null)fname="";}catch(Exception w){w.printStackTrace();}
                                                                String pt = "";
                                                                try{pt = rs.getString(2);if(pt==null)pt="";}catch(Exception e){e.printStackTrace();}
                                                                
                                                                if(!fname.equals("") && !pt.equals("")){
                                                        %>
                                                        <tr>
                                                            <td><%=memberList.get(j)%></td>
                                                            <td><%=rs.getString("fullname")%></td>
                                                            <td><%=rs.getString(2)%></td>
                                                            <td><%=disp_curdt%></td>
                                                        </tr>
                                                        <%
                                                                }
                                                            }
                                                            }
                                                        }catch(Exception e){e.printStackTrace();}
                                                        %>
                                                    </tbody>
                                                </table>
                                        </div>





                                    <!--    <button type="submit" class="btn btn-primary">Submit</button> -->
                                    </div><!-- /.box-body -->



                                </div><!-- /.box -->


                            </div>
                           
                            <!-- /.box-body -->
                        </form>

                    </div><!-- /.box -->
            </div><!--/.col (left) -->
            <!-- right column -->

        </div>   <!-- /.row -->
    </section><!-- /.content -->
</div><!-- /.content-wrapper -->

<%@include file="footer/footer.jsp" %>

<!-- Control Sidebar -->

<!-- Add the sidebar's background. This div must be placed
     immediately after the control sidebar -->


<!-- jQuery 2.1.4 -->

<!-- Bootstrap 3.3.2 JS -->
<script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<!-- FastClick -->
<script src='plugins/fastclick/fastclick.min.js'></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js" type="text/javascript"></script>
<!-- Sparkline -->
<script src="plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
<!-- jvectormap -->
<script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
<script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>
<!-- SlimScroll 1.3.0 -->
<script src="plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<!-- ChartJS 1.0.1 -->
<script src="plugins/chartjs/Chart.min.js" type="text/javascript"></script>

<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<!--<script src="dist/js/pages/dashboard2.js" type="text/javascript"></script>-->

<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js" type="text/javascript"></script>
<script>
    $(function () {
        // $("#date").datepicker();
        $('#date').datepicker({
            format: "mm/dd/yyyy"
        });
    });
</script>

</body>
</html>
<%} else {
        response.sendRedirect("super_admin_login.jsp");
    }
%>

