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

	public static void main(String[] args) throws Exception
	{
		QA4();
	}

	public static void QA4() throws Exception
	{
		String QA4Path = "/home/csd154server/ClusteringDatasets/Jain.arff";
		String outfolder = "/home/csd154server/Q4Out/";
		Instances QA4data = readData(QA4Path);
		int minpts = 5;
		double eps = 1;
		for(double j=0.0; j < 1; j = j + 0.05)
		{
			for (int i = 1; i < 20; ++i)
			{
				minpts = i;
				eps = j;
				String outfile = outfolder + "minpts="+i+",eps="+j+".arff";
				
				FilteredClusterer fc = createDBScanClusterer(QA4data, minpts, eps);
				ClusterEvaluation eval = evaluateCluster(fc, QA4data, outfile);
				if (eval.getNumClusters() > 1)System.out.println("Minpts = " + i + ", eps = " + j + ", clusters = " + eval.getNumClusters());
				
//				saveInstanceasARFF(outfile, QA4data);
//				weka.filters.unsupervised.attribute.AddCluster.useFilter(QA4data, fc)
			}
		}		
	}
	
	public static void saveInstanceasARFF(String filename, Instances data) throws IOException
	{
		ArffSaver saver = new ArffSaver();
		saver.setInstances(data);
		saver.setFile(new File(filename));
//		saver.setDestination(new File(filename));   // **not** necessary in 3.5.4 and later
		saver.writeBatch();
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
		
		BufferedWriter writer = new BufferedWriter(new FileWriter(outfile));
		writer.write(predData.getPlotInstances().toString());
//		writer.write(data.toString());
		writer.newLine();
		writer.flush();
		writer.close();
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
//		clusterer.setDatabase_Type("weka.clusterers.forOPTICSAndDBScan.Databases.SequentialDatabase");
//		clusterer.setDatabase_distanceType("weka.clusterers.forOPTICSAndDBScan.DataObjects.EuclidianDataObject");
	}
	
}

//***Alternate but buggy way to build cluster, -R 3 doesn't work! ***
//weka.clusterers.DBSCAN clusterer = new weka.clusterers.DBSCAN();
//String optionstr = "-R 3 -E " + Double.toString(eps) + " -M " + Integer.toString(minpts) + " -I weka.clusterers.forOPTICSAndDBScan.Databases.SequentialDatabase -D weka.clusterers.forOPTICSAndDBScan.DataObjects.EuclideanDataObject";
//clusterer.setOptions(optionstr.split(" "));
//clusterer.buildClusterer(QA4data);

