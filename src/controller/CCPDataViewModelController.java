package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import dao.CCPDataDaoImpl;
import service.CCPDataService;
import utils.FormatTransformer;
import viewmodel.CCPDataDetailViewModel;
import viewmodel.CCPDataHeadViewModel;
import viewmodel.CCPDataHeatingMonitoringGraphModel;
import viewmodel.CCPDataHeatingMonitoringModel;
import viewmodel.CCPDataMonitoringModel;
import viewmodel.CCPDataStatisticModel;

@WebServlet("/ccpvm")
public class CCPDataViewModelController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	static final Logger logger = 
			Logger.getLogger(CCPDataViewModelController.class.getName());
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		String bizNo = (String) session.getAttribute("bizNo");

		String method = req.getParameter("method");
		
		CCPDataService ccpService = new CCPDataService(new CCPDataDaoImpl(), bizNo);
		
		String result;
		PrintWriter out;
		
		String date = "";
		String processCode = "";
		String sensorId = "";
		
		switch(method) {
		case "head":
			sensorId = req.getParameter("sensorId");
			date = req.getParameter("date");
			processCode = req.getParameter("processCode");
			
			List<CCPDataHeadViewModel> cvmHeadList = ccpService.getCCPDataHeadViewModels(sensorId, date, date, processCode);
			result = FormatTransformer.toJson(cvmHeadList);
			
			res.setContentType("application/json; charset=UTF-8");
			out = res.getWriter();
			
			out.print(result);
			break;
		case "detail":
			String sensorKey = req.getParameter("sensorKey");
			processCode = req.getParameter("processCode");
			
			List<CCPDataDetailViewModel> cvmDetailList = ccpService.getCCPDataDetailViewModels(sensorKey, processCode);
			result = FormatTransformer.toJson(cvmDetailList);
			
			res.setContentType("application/json; charset=UTF-8");
			out = res.getWriter();
			
			out.print(result);
			break;
		case "statistic":
			String toDate = req.getParameter("toDate");
			sensorId = req.getParameter("sensorId");
			
			List<CCPDataStatisticModel> cvmStatisticList = ccpService.getCCPDataStatisticModel(toDate, sensorId);
			result = FormatTransformer.toJson(cvmStatisticList);
			
			res.setContentType("application/json; charset=UTF-8");
			out = res.getWriter();
			
			out.print(result);
			break;
		case "monitoring":
			String toDates = req.getParameter("toDay");
			processCode = req.getParameter("processCode");
			
			List<CCPDataMonitoringModel> cvmMonitoringList = ccpService.getCCPDataMonitoringModel(toDates, processCode);
			result = FormatTransformer.toJson(cvmMonitoringList);
			
			res.setContentType("application/json; charset=UTF-8");
			out = res.getWriter();
			
			out.print(result);
			break;
		case "metal-breakaway":
			String sensorKey2 = req.getParameter("sensorKey");
			String sensorId2 = req.getParameter("sensorId");
			String processCode2 = req.getParameter("processCode");
			String toDate2 = req.getParameter("toDate");
			String fromDate = req.getParameter("fromDate");
			List<CCPDataDetailViewModel> cvmDetailList2 = ccpService.getMetalBreakAwayList(sensorKey2, sensorId2, processCode2, toDate2, fromDate);
			result = FormatTransformer.toJson(cvmDetailList2);
			
			res.setContentType("application/json; charset=UTF-8");
			out = res.getWriter();
			
			out.print(result);
			break;
		case "heating-monitoring":
			sensorId = req.getParameter("sensorId");
			date = req.getParameter("date");
			processCode = req.getParameter("processCode");
			
			List<CCPDataHeatingMonitoringModel> cvmHeatingMonitoringList = ccpService.getCCPHeatingMonitoringModels(sensorId, date, date, processCode);
			result = FormatTransformer.toJson(cvmHeatingMonitoringList);
			
			res.setContentType("application/json; charset=UTF-8");
			out = res.getWriter();
			
			out.print(result);
			break;
		case "heating-monitoring-detail":
			sensorKey = req.getParameter("sensorKey");
			sensorId = req.getParameter("sensorId");
			List<CCPDataHeatingMonitoringGraphModel> cvmHeatingMonitoringGraphList = ccpService.getCCPHeatingMonitoringGraphModels(sensorKey, sensorId);
			result = FormatTransformer.toJson(cvmHeatingMonitoringGraphList);
			System.out.println("result############################");
			System.out.println(result);
			res.setContentType("application/json; charset=UTF-8");
			out = res.getWriter();
			
			out.print(result);
			break;
		case "heating-monitoring-detail2":
			sensorKey = req.getParameter("sensorKey");
			sensorId = req.getParameter("sensorId");
			List<CCPDataHeatingMonitoringGraphModel> cvmHeatingMonitoringGraphList2 = ccpService.getCCPHeatingMonitoringGraphModels2(sensorKey, sensorId);
			result = FormatTransformer.toJson(cvmHeatingMonitoringGraphList2);
			System.out.println("result############################");
			System.out.println(result);
			res.setContentType("application/json; charset=UTF-8");
			out = res.getWriter();
			
			out.print(result);
			break;
		}
		
		
		
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		doGet(req, res);
	}
}
