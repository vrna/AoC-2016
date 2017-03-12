/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aoc_14;
//import java.security.DigestInputStream;
import java.awt.List;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 *
 * @author Artturi
 */
public class AoC_14 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws Exception {
        // TODO code application logic here
        //String input = "ahsbgdzn";
        String input = "ahsbgdzn";
        Boolean part1 = false;
        ArrayList< Integer > keys = new ArrayList<Integer> ();
        //ArrayList<Integer> triples = new ArrayList<Integer>();
        HashMap<String,ArrayList<Integer>> triples = new HashMap<String,ArrayList<Integer>>();
        
        Integer lastTriple = -1;
        Integer index = 0;
        while( true) {
            if(index == 816)
            {
                String foo = "bar";
            }
            String code = input + index.toString();
            // create a hash
            String hash = "";
            if(part1)
            {
                hash = md5hash(code);
            }
            else
            {
                hash = md5stretchedHash(code);
            }
            // check if it contains three characters of one kind
            Pattern pattern3 = Pattern.compile("([a-z\\d])\\1\\1", Pattern.CASE_INSENSITIVE);
            
            Matcher m3 = pattern3.matcher(hash);
            if( m3.find() )
            {
                lastTriple = index;
                String key = Character.toString(hash.charAt(m3.start()));
                if(!triples.containsKey(key))
                {
                    ArrayList<Integer> occurences = new ArrayList<Integer>();
                    occurences.add(index);
                    triples.put(key, occurences);
                }
                else
                {
                    triples.get(key).add(index);
                }
                
                Pattern pattern5 = Pattern.compile("([a-z\\d])\\1\\1\\1\\1", Pattern.CASE_INSENSITIVE);

                Matcher m5 = pattern5.matcher(hash);
                
                if(m5.find() )
                {
                    String key5 = Character.toString(hash.charAt(m5.start()));
                    
                    if( triples.containsKey(key5))
                    {
                        for(Iterator<Integer> i = triples.get(key5).iterator(); i.hasNext(); ) {
                            Integer item = i.next();
                            
                            if(item + 1000 >= index && item != index) 
                            {
                                keys.add(item);
                                // this is slow, remove when you find out why it not works
                                //String orig = md5hash(input + item.toString());
                                //String pair = md5hash(input + index.toString());
                                //System.out.println("found pair in " + item.toString());
                                //System.out.println("o: " + orig + "(" + item.toString() + ")");
                                //System.out.println("å: " + pair + "(" + index.toString() + ")");
                                if(keys.size() >= 64 && index > lastTriple + 1000)
                                {
                                    break;
                                }
                            }
                        }
                    }
                }
            }
            index++;
            if( index > 30000)
            {
                break;
            }
        }
        Collections.sort(keys);
        System.out.println(keys.get(63));
    }

    
    public static String md5hash(String code) throws Exception {
         //MessageDigest m=MessageDigest.getInstance("MD5");
         //m.update(code.getBytes(),0,code.length());
         //String hex = (new HexBinaryAdapter()).marshal(md5.digest(code.getBytes()))
         //return new BigInteger(1,m.digest()).toString(16);

        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] arr = md.digest(code.getBytes());
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < arr.length; i++)
            sb.append(Integer.toString((arr[i] & 0xff) + 0x100, 16).substring(1));
        
        return sb.toString();
    }
    
    public static String md5HexHash(String code) throws Exception {
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] arr = md.digest(code.getBytes());
        StringBuilder hexString = new StringBuilder();

        for (int i = 0; i < arr.length; i++) {
            String hex = Integer.toHexString(0xFF & arr[i]);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }

        return hexString.toString();
    }
    
    public static String md5stretchedHash(String code) throws Exception {
        String hash = code;
        for(int i = 0; i <= 2016; i++)
        {
            hash = md5HexHash(hash);
        }
        return hash;
    }
}
