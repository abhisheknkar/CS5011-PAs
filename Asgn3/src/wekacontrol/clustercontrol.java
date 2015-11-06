package wekacontrol;
import weka.clusterers.ClusterEvaluation;
import weka.clusterers.Clusterer;
import weka.clusterers.FilteredClusterer;
import weka.core.Instances;
import weka.core.converters.ArffSaver;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import weka.filters.unsupervised.attribute.AddCluster;
import weka.filters.unsupervised.attribute.Remove;
import weka.gui.explorer.ClustererPanel;
import weka.gui.visualize.PlotData2D;

public class clustercontrol 
{
	static double epsmin=0.0;
	static double epsmax=1.0;
	static double epsdelta=0.05;
	static int ptsmin = 1;
	static int ptsmax = 20;
	static int ptsdelta = 1;
	
	public static void main(String[] args) throws Exception
	{
//		QA4();
//		QA5();
		QA6();
	}

	public static void QA4() throws Exception
	{
		String arffPath = "/home/csd154server/ClusteringDatasets/Jain.arff";
		String outfolder = "/home/csd154server/QA4Out/";
		File outfolder0 = new File(outfolder);
		outfolder0.mkdirs();
		executeDBSCAN(arffPath, outfolder);
	}

	public static void QA5() throws Exception
	{
		String arffPath,outfolder;
		arffPath = "/home/csd154server/ClusteringDatasets/Path-based.arff";
		outfolder = "/home/csd154server/QA5Out_Path-based_DBSCAN/";
//		arffPath = "/home/csd154server/ClusteringDatasets/Spiral.arff";
//		outfolder = "/home/csd154server/QA5Out_Spiral_DBSCAN/";
//		arffPath = "/home/csd154server/ClusteringDatasets/Flames.arff";
//		outfolder = "/home/csd154server/QA5Out_Flames_DBSCAN/";
		File outfolder0 = new File(outfolder);
		outfolder0.mkdirs();
		executeDBSCAN(arffPath, outfolder);
	}

	public static void QA6() throws Exception
	{
		String arffPath,outfolder;
		arffPath = "/home/csd154server/ClusteringDatasets/D31.arff";
		outfolder = "/home/csd154server/QA6Out_D31_DBSCAN/";
		File outfolder0 = new File(outfolder);
		outfolder0.mkdirs();
		executeDBSCAN(arffPath, outfolder);
	}
	
	public static void executeDBSCAN(String arffPath, String outfolder) throws Exception
	{
		Instances data = readData(arffPath);
		int minpts = 5;
		double eps = 1;
		for(double j=epsmin; j < epsmax; j = j + epsdelta)
		{
			for (int i = ptsmin; i < ptsmax; i+=ptsdelta)
			{
				minpts = i;
				eps = j;
				String outfile = outfolder + "minpts="+i+",eps="+j+".arff";
				
				FilteredClusterer fc = createDBScanClusterer(data, minpts, eps);
				ClusterEvaluation eval = evaluateCluster(fc, data, outfile);
				if (eval.getNumClusters() > 1)System.out.println("Minpts = " + i + ", eps = " + j + ", clusters = " + eval.getNumClusters());
			}
		}		
	}
	
	public static ClusterEvaluation evaluateCluster(FilteredClusterer fc, Instances data, String outfile) throws Exception
	{
//		***Evaluate Cluster***
		ClusterEvaluation eval = new ClusterEvaluation();
//		eval.setClusterer(clusterer);
		eval.setClusterer(fc);
		eval.evaluateClusterer(data);
		outfile = outfile.substring(0, outfile.length()-5) + ",clusters="+Integer.toString(eval.getNumClusters()) + ".arff";
//		System.out.println(eval.clusterResultsToString());
		PlotData2D predData = ClustererPanel.setUpVisualizableInstances(data, eval);

		if(eval.getNumClusters()>1)
		{
			BufferedWriter writer = new BufferedWriter(new FileWriter(outfile));
			writer.write(predData.getPlotInstances().toString());
//			writer.write(data.toString());
			writer.newLine();
			writer.flush();
			writer.close();
		}
		return eval;
	}

	public static Instances readData(String path) throws IOException
	{
		BufferedReader reader = new BufferedReader(new FileReader(path));
		Instances data = new Instances(reader);
		reader.close();
		return data;
	}

	public static FilteredClusterer createDBScanClusterer(Instances data, int minpts, double eps) throws Exception
	{
		FilteredClusterer fc = new FilteredClusterer();
		weka.clusterers.DBSCAN clusterer = new weka.clusterers.DBSCAN();   // new instance of clusterer
		clusterer.setEpsilon(eps);
		clusterer.setMinPoints(minpts);

		Remove remove = new Remove(); // new instance of filter
		remove.setOptions("-R 3".split(" ")); // set options
		remove.setInputFormat(data); // inform filter about dataset
		fc.setFilter(remove); //add filter to remove attributes
		fc.setClusterer(clusterer);
		fc.buildClusterer(data);
		
		AddCluster out = new AddCluster();
		out.setClusterer(clusterer);
		
		return fc;
	}	
}