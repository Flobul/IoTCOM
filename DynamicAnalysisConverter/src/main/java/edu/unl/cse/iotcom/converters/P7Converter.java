package edu.unl.cse.iotcom.converters;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.jgrapht.Graph;
import org.jgrapht.GraphPath;
import org.jgrapht.alg.shortestpath.DijkstraShortestPath;
import org.jgrapht.graph.DefaultEdge;
import org.w3c.dom.Node;

import com.google.common.base.Optional;
import com.google.common.collect.Iterables;
import com.google.common.collect.Sets;

import edu.unl.cse.iotcom.ThreatConverter;

public class P7Converter extends ThreatConverter {

	@Override
	public String convert(Graph<String, DefaultEdge> connected, Node xml) throws Exception {
		// for P7, we want to find two skolems: r and predecessor
		String r_ = xpath.findStr("//skolem[@label=\"$P7_r\"]/tuple/atom/@label", xml);
		String p_ = xpath.findStr("//skolem[@label=\"$P7_predecessor\"]/tuple/atom/@label", xml);
		// find the paths between predecessor and r
		GraphPath<String, DefaultEdge> p_TOr_ = DijkstraShortestPath.findPathBetween(connected, p_, r_);
		List<Rule> p_TOr_Rules = new ArrayList<>();
		for (String lbl : p_TOr_.getVertexList()) {
			p_TOr_Rules.add(getRule(lbl, xml));
		}
		// find the trigger event
		Optional<CavTriple> p_cav = Optional.absent();
		if (!p_cav.isPresent())
			p_cav = Iterables.tryFind(p_TOr_Rules.get(0).trgs,
					cav -> cav.atr.equals("motion") && cav.val.equals("inactive"));
		if (!p_cav.isPresent())
			p_cav = Optional.of(Iterables.getFirst(p_TOr_Rules.get(0).trgs, null));
		Set<CavTriple> event = Sets.newHashSet(p_cav.get());
		// walk the lists of rules and accumulate any conditions that need satisfied
		Set<CavTriple> configs = new HashSet<>();
		Set<CavTriple> altered = new HashSet<>();
		Set<String> apps = new HashSet<>();
		altered.addAll(event);
		p_TOr_Rules.stream().forEach(x -> {
			for (CavTriple cnd : x.cnds) {
				if (!configs.contains(cnd) && !altered.contains(cnd)) {
					configs.add(cnd);
				}
			}
			altered.addAll(x.acts);
			apps.add(x.app);
		});

		return build("P7", apps, configs, event, xml);
	}

}