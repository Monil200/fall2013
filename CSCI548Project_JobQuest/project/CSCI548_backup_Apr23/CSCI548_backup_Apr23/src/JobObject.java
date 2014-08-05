
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;

public class JobObject implements Comparable<JobObject>{
	public String job_title;
	public String job_href;
	public Date job_date;
	public String cname_text;
	public String cname_href;
	public String curl;
	public String chq;
	public String cstock;
	public String crating;	
	public String csatisfaction;
	public String ceo_name;
	public String ceo_rating;
	public String csalary_href;	
	public String creview_href;
	public String cint_href;
	public String source; 
	
	@Override
	public int compareTo(JobObject o) {
		if(this.job_date.compareTo(o.job_date) == -1)
			return 1;
		else if(this.job_date.compareTo(o.job_date) == 1)
			return -1;
		else
			return 0;
	}
	
	@Override
	public boolean equals(Object o) {
		if (o == null)
		   return false;
	    if (o == this)
	       return true;
	    if (o.getClass() != getClass())
	       return false;
	    JobObject e = (JobObject) o;
	    return new EqualsBuilder()
	              .append((this.source!=null)?this.source:"17", (this.source!=null)?this.source:"17")
	              .append((this.ceo_name!=null)?this.ceo_name:"31", (this.ceo_name!=null)?this.ceo_name:"31")
	              .isEquals();
    } 
	
	@Override
	public int hashCode(){
		final int PRIME1 = 17;
		final int PRIME2 = 31;
		return new HashCodeBuilder((this.job_title != null)?this.job_title.length():PRIME1, PRIME2)
				.append((this.source!=null)?this.source:"17")
				.append((this.ceo_name!=null)?this.ceo_name:"31")
				.toHashCode();
	}
}
