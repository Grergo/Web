package SQL;

import java.awt.List;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;




/**
 * Servlet implementation class PMServlet
 */
@WebServlet("/PMServlet")
public class PMServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PMServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Map<String, String>product_infoMap=analysis_Post(request);
		MPutils mPutils=new MPutils();
		if(product_infoMap.get("flag").equals("add")) {
			mPutils.insertProduct(product_infoMap.get("prodname"), product_infoMap.get("prodid"), product_infoMap.get("isspecial"), product_infoMap.get("isfashion"), product_infoMap.get("prodprice"), product_infoMap.get("prodimg"),product_infoMap.get("prodtype"));
		}else if (product_infoMap.get("flag").equals("change")) {
			mPutils.Update_Product(product_infoMap.get("prodname"), product_infoMap.get("isspecial"), product_infoMap.get("isfashion"), product_infoMap.get("prodprice"), product_infoMap.get("prodtype"), product_infoMap.get("prodid"));
		}else if (product_infoMap.get("flag").equals("del")) {
			mPutils.del_product(product_infoMap.get("prodid"));
		}
	}
	protected Map<String, String> analysis_Post(HttpServletRequest request) {
		Map<String, String>productinfoMap=new HashMap<String,String>();
		if(ServletFileUpload.isMultipartContent(request)) {
			productinfoMap.put("flag", "add");
			try {
				DiskFileItemFactory factory= new DiskFileItemFactory();
				ServletFileUpload sfUpload=new ServletFileUpload(factory);
				sfUpload.setSizeMax(10*1024*1024);
				sfUpload.setHeaderEncoding("utf-8");
				java.util.List<FileItem> fileItem_list=sfUpload.parseRequest(request);
				Iterator<FileItem>fileitems=fileItem_list.iterator();
				while(fileitems.hasNext()) {
					FileItem fileItem=fileitems.next();
					if(fileItem.isFormField()) {
						String name=fileItem.getName();
						String value=fileItem.getString("utf-8");
						productinfoMap.put(name, value);
						System.out.println(name+"="+value);
					}else {
						String filename=fileItem.getName();
						String uuid=UUID.randomUUID().toString().replaceAll("-", "");
						String suffixName=filename.substring(filename.lastIndexOf('.'));
						filename=uuid+suffixName;
						File file=new File(this.getServletContext().getRealPath("/WebContent/Resource/images/ProductImages/")+filename);
						fileItem.write(file);
						fileItem.delete();
						productinfoMap.put("prodimg", "../images/ProductImages/"+filename);
					}
				}
			} catch (Exception e) {
				System.out.println(e.getLocalizedMessage());
			}
		}else {
			productinfoMap.put("flag",request.getParameter("flag"));
			productinfoMap.put("prodname", request.getParameter("prodname"));
			productinfoMap.put("isspecial", request.getParameter("isspecial"));
			productinfoMap.put("isfashion", request.getParameter("isfashion"));
			productinfoMap.put("prodprice", request.getParameter("prodprice"));
			productinfoMap.put("prodtype", request.getParameter("prodtype"));
			productinfoMap.put("prodid", request.getParameter("prodid"));
		}
		return productinfoMap;
	}

}
